import streamlit as st
import pandas as pd    
import psycopg2
from psycopg2 import sql 
import os
from dotenv import load_dotenv
import plotly.express as px

# Load environment variables
load_dotenv()

# Database connection parameters
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            sslmode='require'
        )
        return conn
    except Exception as e:
        st.error(f"Failed to connect to database: {e}")
        return None

# --- DATA FETCHING FUNCTIONS ---

def search_records(search_term, search_field, limit=100):
    conn = get_db_connection()
    if not conn: return pd.DataFrame()
    try:
        with conn.cursor() as cur:
            table_name = 'black_loyalist_directory'
            search_pattern = f'%{search_term}%'
            
            if search_field == 'all':
                # Logic to support "First + Last" name searching
                query = sql.SQL("""
                    SELECT * FROM {table} WHERE 
                    ("First_Name" || ' ' || "Surname") ILIKE %s OR
                    "ID" ILIKE %s OR "Ship_Name" ILIKE %s OR 
                    "First_Name" ILIKE %s OR "Surname" ILIKE %s OR
                    "Description" ILIKE %s OR "Notes" ILIKE %s
                    LIMIT %s
                """).format(table=sql.Identifier(table_name))
                params = [search_pattern] * 7 + [limit]
            else:
                query = sql.SQL("SELECT * FROM {table} WHERE {col} ILIKE %s LIMIT %s").format(
                    table=sql.Identifier(table_name),
                    col=sql.Identifier(search_field)
                )
                params = [search_pattern, limit]

            cur.execute(query, params)
            columns = [desc[0] for desc in cur.description]
            return pd.DataFrame(cur.fetchall(), columns=columns)
    finally:
        conn.close()

def get_distribution_data(column_name, limit=None):
    conn = get_db_connection()
    if not conn: return pd.DataFrame()
    try:
        with conn.cursor() as cur:
            limit_clause = sql.SQL("LIMIT %s") if limit else sql.SQL("")
            query = sql.SQL("""
                SELECT {col} as label, COUNT(*) as count 
                FROM black_loyalist_directory 
                WHERE {col} IS NOT NULL AND {col} != '-'
                GROUP BY {col} ORDER BY count DESC {limit}
            """).format(col=sql.Identifier(column_name), limit=limit_clause)
            cur.execute(query, [limit] if limit else [])
            return pd.DataFrame(cur.fetchall(), columns=['Label', 'count'])
    finally:
        conn.close()

# --- UI COMPONENTS ---

def display_profile_card(row):
    """The Profile layout mimicking the USCT document screenshot"""
    full_name = f"{row.get('First_Name', '')} {row.get('Surname', '')}".strip()
    st.markdown(f"## {full_name}")
    
    col1, col2 = st.columns([1, 2])
    
    with col1:
        st.info("📜 **Source Record**")
        st.write(f"**ID:** {row.get('ID')}")
        st.write(f"**Book:** {row.get('Book')}")
        st.write(f"**Ref Page:** {row.get('Ref_Page')}")
        st.caption(f"Source 1: {row.get('Primary_Source_1')}")

    with col2:
        # Section: Military/Voyage
        st.subheader("🚢 Voyage & Service")
        c_v1, c_v2 = st.columns(2)
        c_v1.write(f"**Ship:** {row.get('Ship_Name')}")
        c_v1.write(f"**Commander:** {row.get('Commander')}")
        c_v2.write(f"**Departure:** {row.get('Departure_Port')}")
        c_v2.write(f"**Date:** {row.get('Departure_Date')}")

        # Section: Residence/Origin
        st.subheader("📍 Residence")
        c_r1, c_r2 = st.columns(2)
        c_r1.write(f"**Origin State:** {row.get('Origination_State')}")
        c_r2.write(f"**Arrival Port:** {row.get('Arrival_Port_City')}")

        # Section: Physical Characteristics
        st.subheader("🧬 Physical Characteristics")
        c_p1, c_p2, c_p3 = st.columns(3)
        c_p1.write(f"**Age:** {row.get('Age')}")
        c_p1.write(f"**Gender:** {row.get('Gender')}")
        c_p2.write(f"**Race:** {row.get('Race')}")
        c_p2.write(f"**Ethnicity:** {row.get('Ethnicity')}")
        c_p3.write(f"**Description:** {row.get('Description')}")

    if row.get('Notes'):
        with st.expander("📝 View Remarks / Notes", expanded=True):
            st.write(row.get('Notes'))

# --- MAIN APP ---

st.set_page_config(page_title="Book of Negroes Database Dashboard", layout="wide")
st.title("📚 Book of Negroes Database Dashboard")

# Sidebar Search
st.sidebar.header("🔍 Search Records")
search_term = st.sidebar.text_input("Search Name (e.g. Samuel Gullet)")
search_field = st.sidebar.selectbox("Field", ['all', 'First_Name', 'Surname', 'Ship_Name', 'ID'], index=0)
limit = st.sidebar.selectbox("Max Results", [50, 100, 500], index=0)

if search_term:
    results = search_records(search_term, search_field, limit)
    if not results.empty:
        st.success(f"Found {len(results)} records")
        
        # Profile Selector
        selected_idx = st.selectbox(
            "Select a person to view details:", 
            options=range(len(results)),
            format_func=lambda x: f"{results.iloc[x]['First_Name']} {results.iloc[x]['Surname']} (ID: {results.iloc[x]['ID']})"
        )
        display_profile_card(results.iloc[selected_idx])
        
        with st.expander("📊 View Raw Data Table"):
            st.dataframe(results, use_container_width=True)
    else:
        st.info("No matching records found.")

# --- ANALYTICS SECTION (Always Visible) ---
st.divider()
st.header("📈 Demographics & Composition Analysis")

tab1, tab2, tab3, tab4 = st.tabs(["Race", "Ethnicity", "Gender", "Top Descriptions"])

with tab1:
    data = get_distribution_data("Race")
    if not data.empty:
        fig = px.bar(data, x='Label', y='count', title="Race Distribution", color='count', color_continuous_scale='Viridis')
        st.plotly_chart(fig, use_container_width=True)
        st.plotly_chart(px.pie(data, values='count', names='Label'), use_container_width=True)

with tab2:
    data = get_distribution_data("Ethnicity")
    if not data.empty:
        fig = px.bar(data, x='Label', y='count', title="Ethnicity Distribution", color='count', color_continuous_scale='Blues')
        st.plotly_chart(fig, use_container_width=True)

with tab3:
    data = get_distribution_data("Gender")
    if not data.empty:
        st.plotly_chart(px.pie(data, values='count', names='Label', title="Gender Distribution"), use_container_width=True)

with tab4:
    data = get_distribution_data("Description", limit=20)
    if not data.empty:
        fig = px.bar(data, y='Label', x='count', orientation='h', title="Top 20 Descriptions", color='count', color_continuous_scale='Reds')
        st.plotly_chart(fig, use_container_width=True)