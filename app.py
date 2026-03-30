import streamlit as st
import pandas as pd
import psycopg2
from psycopg2 import sql 
import os
from dotenv import load_dotenv
import plotly.express as px
import plotly.graph_objects as go

# Load environment variables
load_dotenv()

# Database connection parameters
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')

def get_db_connection():
    """Establish database connection"""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            sslmode='require'  # For Azure Postgres
        )
        return conn
    except Exception as e:
        st.error(f"Failed to connect to database: {e}")
        return None

def search_records(search_term, search_field, limit=100):
    """Search records in the database"""
    conn = get_db_connection()
    if not conn:
        return pd.DataFrame()

    try:
        with conn.cursor() as cur:
            # Using the actual table name from schema
            table_name = 'black_loyalist_directory'

            if search_field == 'all':
                query = sql.SQL("""
                    SELECT * FROM {} WHERE
                    "ID" ILIKE %s OR
                    "Ref_Page" ILIKE %s OR
                    "Book" ILIKE %s OR
                    "Ship_Name" ILIKE %s OR
                    "Commander" ILIKE %s OR
                    "First_Name" ILIKE %s OR
                    "Surname" ILIKE %s OR
                    "Father_FirstName" ILIKE %s OR
                    "Father_Surname" ILIKE %s OR
                    "Mother_FirstName" ILIKE %s OR
                    "Mother_Surname" ILIKE %s OR
                    "Gender" ILIKE %s OR
                    "Age" ILIKE %s OR
                    "Race" ILIKE %s OR
                    "Ethnicity" ILIKE %s OR
                    "Description" ILIKE %s OR
                    "Origination_Port" ILIKE %s OR
                    "Origination_State" ILIKE %s OR
                    "Departure_Port" ILIKE %s OR
                    "Departure_Date" ILIKE %s OR
                    "Arrival_Port_City" ILIKE %s OR
                    "Primary_Source_1" ILIKE %s OR
                    "Primary_Source_2" ILIKE %s OR
                    "Notes" ILIKE %s
                    LIMIT %s
                """).format(sql.Identifier(table_name))

                search_pattern = f'%{search_term}%'
                params = [search_pattern] * 23 + [limit]
            else:
                # Map field names to actual column names
                column_mapping = {
                    'id': '"ID"',
                    'ref_page': '"Ref_Page"',
                    'book': '"Book"',
                    'ship_name': '"Ship_Name"',
                    'commander': '"Commander"',
                    'first_name': '"First_Name"',
                    'surname': '"Surname"',
                    'father_firstname': '"Father_FirstName"',
                    'father_surname': '"Father_Surname"',
                    'mother_firstname': '"Mother_FirstName"',
                    'mother_surname': '"Mother_Surname"',
                    'gender': '"Gender"',
                    'age': '"Age"',
                    'race': '"Race"',
                    'ethnicity': '"Ethnicity"',
                    'description': '"Description"',
                    'origination_port': '"Origination_Port"',
                    'origination_state': '"Origination_State"',
                    'departure_port': '"Departure_Port"',
                    'departure_date': '"Departure_Date"',
                    'arrival_port_city': '"Arrival_Port_City"',
                    'primary_source_1': '"Primary_Source_1"',
                    'primary_source_2': '"Primary_Source_2"',
                    'notes': '"Notes"'
                }

                actual_column = column_mapping.get(search_field, search_field)
                query = sql.SQL("SELECT * FROM {} WHERE {} ILIKE %s LIMIT %s").format(
                    sql.Identifier(table_name),
                    sql.SQL(actual_column)
                )
                params = [f'%{search_term}%', limit]

            cur.execute(query, params)
            columns = [desc[0] for desc in cur.description]
            results = cur.fetchall()

            return pd.DataFrame(results, columns=columns)

    except Exception as e:
        st.error(f"Error executing query: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

def get_table_info():
    """Get table structure and record count"""
    conn = get_db_connection()
    if not conn:
        return None, 0

    try:
        with conn.cursor() as cur:
            table_name = 'black_loyalist_directory'

            # Get column information
            cur.execute(sql.SQL("""
                SELECT column_name, data_type, is_nullable
                FROM information_schema.columns
                WHERE table_name = %s
                ORDER BY ordinal_position
            """), [table_name])
            columns = cur.fetchall()

            # Get record count
            cur.execute(sql.SQL("SELECT COUNT(*) FROM {}").format(sql.Identifier(table_name)))
            count = cur.fetchone()[0]

            return columns, count

    except Exception as e:
        st.error(f"Error getting table info: {e}")
        return None, 0
    finally:
        conn.close()

def get_race_distribution():
    """Get count of people by race"""
    conn = get_db_connection()
    if not conn:
        return pd.DataFrame()

    try:
        with conn.cursor() as cur:
            query = sql.SQL("""
                SELECT "Race", COUNT(*) as count
                FROM black_loyalist_directory
                WHERE "Race" IS NOT NULL AND "Race" != '-'
                GROUP BY "Race"
                ORDER BY count DESC
            """)
            cur.execute(query)
            columns = [desc[0] for desc in cur.description]
            results = cur.fetchall()
            return pd.DataFrame(results, columns=columns)
    except Exception as e:
        st.error(f"Error fetching race distribution: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

def get_ethnicity_distribution():
    """Get count of people by ethnicity"""
    conn = get_db_connection()
    if not conn:
        return pd.DataFrame()

    try:
        with conn.cursor() as cur:
            query = sql.SQL("""
                SELECT "Ethnicity", COUNT(*) as count
                FROM black_loyalist_directory
                WHERE "Ethnicity" IS NOT NULL AND "Ethnicity" != '-'
                GROUP BY "Ethnicity"
                ORDER BY count DESC
            """)
            cur.execute(query)
            columns = [desc[0] for desc in cur.description]
            results = cur.fetchall()
            return pd.DataFrame(results, columns=columns)
    except Exception as e:
        st.error(f"Error fetching ethnicity distribution: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

def get_description_distribution():
    """Get count of people by description"""
    conn = get_db_connection()
    if not conn:
        return pd.DataFrame()

    try:
        with conn.cursor() as cur:
            query = sql.SQL("""
                SELECT "Description", COUNT(*) as count
                FROM black_loyalist_directory
                WHERE "Description" IS NOT NULL AND "Description" != '-'
                GROUP BY "Description"
                ORDER BY count DESC
                LIMIT 20
            """)
            cur.execute(query)
            columns = [desc[0] for desc in cur.description]
            results = cur.fetchall()
            return pd.DataFrame(results, columns=columns)
    except Exception as e:
        st.error(f"Error fetching description distribution: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

def get_gender_distribution():
    """Get count of people by gender"""
    conn = get_db_connection()
    if not conn:
        return pd.DataFrame()

    try:
        with conn.cursor() as cur:
            query = sql.SQL("""
                SELECT "Gender", COUNT(*) as count
                FROM black_loyalist_directory
                WHERE "Gender" IS NOT NULL AND "Gender" != '-'
                GROUP BY "Gender"
                ORDER BY count DESC
            """)
            cur.execute(query)
            columns = [desc[0] for desc in cur.description]
            results = cur.fetchall()
            return pd.DataFrame(results, columns=columns)
    except Exception as e:
        st.error(f"Error fetching gender distribution: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

# Streamlit UI
st.set_page_config(page_title="Book of Negroes Database Dashboard", layout="wide")

st.title("📚 Book of Negroes Database Dashboard")
st.markdown("Search and explore records from the Book of Negroes database")

# Sidebar for search
st.sidebar.header("🔍 Search Records")

search_term = st.sidebar.text_input("Search Term", placeholder="Enter search term...")

search_fields = [
    'all', 'id', 'ref_page', 'book', 'ship_name', 'commander', 'first_name', 'surname',
    'father_firstname', 'father_surname', 'mother_firstname', 'mother_surname',
    'gender', 'age', 'race', 'ethnicity', 'description', 'origination_port',
    'origination_state', 'departure_port', 'departure_date', 'arrival_port_city',
    'primary_source_1', 'primary_source_2', 'notes'
]

search_field = st.sidebar.selectbox("Search Field", search_fields, index=0)

limit_options = [50, 100, 200, 500, 1000]
limit = st.sidebar.selectbox("Max Results", limit_options, index=1)

if st.sidebar.button("Search", type="primary"):
    if search_term:
        with st.spinner("Searching database..."):
            results = search_records(search_term, search_field, limit)

        if not results.empty:
            st.success(f"Found {len(results)} records")

            # Display results
            st.dataframe(results, use_container_width=True)

            # Download button
            csv = results.to_csv(index=False)
            st.download_button(
                label="📥 Download Results as CSV",
                data=csv,
                file_name="book_of_negroes_search_results.csv",
                mime="text/csv"
            )
        else:
            st.info("No records found matching your search criteria.")
    else:
        st.warning("Please enter a search term.")

# Database info section
st.header("📊 Database Information")

col1, col2 = st.columns(2)

with col1:
    st.subheader("Table Structure")
    columns, count = get_table_info()
    if columns:
        col_df = pd.DataFrame(columns, columns=['Column Name', 'Data Type', 'Nullable'])
        st.dataframe(col_df, use_container_width=True)
    else:
        st.error("Could not retrieve table structure.")

with col2:
    st.subheader("Statistics")
    if count is not None:
        st.metric("Total Records", f"{count:,}")
    else:
        st.error("Could not retrieve record count.")

# Analytics section
st.header("📈 Demographics & Composition Analysis")
st.markdown("Visualizations showing the demographic distribution of people in the database")

# Create tabs for different visualizations
tab1, tab2, tab3, tab4 = st.tabs(["Race Distribution", "Ethnicity Distribution", "Gender Distribution", "Description Distribution"])

with tab1:
    st.subheader("Racial Composition")
    race_data = get_race_distribution()
    if not race_data.empty:
        # Bar chart
        fig_race = px.bar(
            race_data,
            x='Race',
            y='count',
            title='Distribution of People by Race',
            labels={'count': 'Number of People', 'Race': 'Race'},
            color='count',
            color_continuous_scale='Viridis'
        )
        fig_race.update_layout(showlegend=False, height=500)
        st.plotly_chart(fig_race, use_container_width=True)
        
        # Pie chart
        fig_race_pie = px.pie(
            race_data,
            values='count',
            names='Race',
            title='Race Distribution (Percentage)'
        )
        fig_race_pie.update_layout(height=500)
        st.plotly_chart(fig_race_pie, use_container_width=True)
    else:
        st.info("No race data available")

with tab2:
    st.subheader("Ethnic Composition")
    ethnicity_data = get_ethnicity_distribution()
    if not ethnicity_data.empty:
        # Bar chart
        fig_eth = px.bar(
            ethnicity_data,
            x='Ethnicity',
            y='count',
            title='Distribution of People by Ethnicity',
            labels={'count': 'Number of People', 'Ethnicity': 'Ethnicity'},
            color='count',
            color_continuous_scale='Blues'
        )
        fig_eth.update_layout(showlegend=False, height=500)
        st.plotly_chart(fig_eth, use_container_width=True)
        
        # Pie chart
        fig_eth_pie = px.pie(
            ethnicity_data,
            values='count',
            names='Ethnicity',
            title='Ethnicity Distribution (Percentage)'
        )
        fig_eth_pie.update_layout(height=500)
        st.plotly_chart(fig_eth_pie, use_container_width=True)
    else:
        st.info("No ethnicity data available")

with tab3:
    st.subheader("Gender Composition")
    gender_data = get_gender_distribution()
    if not gender_data.empty:
        # Bar chart
        fig_gender = px.bar(
            gender_data,
            x='Gender',
            y='count',
            title='Distribution of People by Gender',
            labels={'count': 'Number of People', 'Gender': 'Gender'},
            color='Gender',
            color_discrete_sequence=['#FF6B9D', '#4A90E2', '#F5A623', '#7ED321']
        )
        fig_gender.update_layout(showlegend=False, height=500)
        st.plotly_chart(fig_gender, use_container_width=True)
        
        # Pie chart
        fig_gender_pie = px.pie(
            gender_data,
            values='count',
            names='Gender',
            title='Gender Distribution (Percentage)'
        )
        fig_gender_pie.update_layout(height=500)
        st.plotly_chart(fig_gender_pie, use_container_width=True)
    else:
        st.info("No gender data available")

with tab4:
    st.subheader("Description Categories")
    description_data = get_description_distribution()
    if not description_data.empty:
        # Horizontal bar chart for better readability
        fig_desc = px.bar(
            description_data,
            y='Description',
            x='count',
            orientation='h',
            title='Top 20 Description Categories',
            labels={'count': 'Number of People', 'Description': 'Description'},
            color='count',
            color_continuous_scale='Reds'
        )
        fig_desc.update_layout(showlegend=False, height=600)
        st.plotly_chart(fig_desc, use_container_width=True)
    else:
        st.info("No description data available")

# Footer
st.markdown("---")
# st.markdown("*Dashboard for exploring Book of Negroes records stored in Azure PostgreSQL*")