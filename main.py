import os
import psycopg2
import logging


ENDPOINT = os.environ["DB_URI"]
DBNAME = os.environ["DB_NAME"]
USER = os.environ["DB_USER"]
PWD = os.environ["DB_PWD"]
REGION = os.environ['DB_REGION']
PORT = os.environ['DB_PORT']

_logger = logging.getLogger()

def connect_to_database():
    _logger.info('Connecting to database...')
    connection = None
    try:
        connection = psycopg2.connect(host=ENDPOINT, database=DBNAME, user=USER, password=PWD)
    except:
        _logger.error('Unable to connect to database.')

    return connection

def print_connection_details():
    connection = connect_to_database()
    _logger.info('Printing results...')
    if connection is None:
        print('Unable to connect to database.')
    else:
        print(f'{connection.info.dsn_parameters}')

if __name__ == '__main__':
    print_connection_details()
