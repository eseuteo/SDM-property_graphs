from neo4j import GraphDatabase

class HelloWorldExample(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(
            uri=uri,
            auth=(user, password),
            encrypted = False, 
            max_connection_lifetime=30 * 60,
            max_connection_pool_size=150, 
            connection_acquisition_timeout=2 * 60,
            connection_timeout=3,
            max_retry_time=1)

    def close(self):
        self._driver.close()

    def print_greeting(self, message):
        with self._driver.session() as session:
            greeting = session.write_transaction(self._create_and_return_greeting, message)
            print(greeting)

    @staticmethod
    def _create_and_return_greeting(tx, message):
        result = tx.run("CREATE (a:Greeting) "
                        "SET a.message = $message "
                        "RETURN a.message + ', from node ' + id(a)", message=message)
        return result.single()[0]


example = HelloWorldExample("bolt://localhost:7687", "neo4j", "password")
example.print_greeting("greeting message")
example.close()