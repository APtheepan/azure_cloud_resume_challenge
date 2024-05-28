import azure.functions as func
import logging
from azure.cosmos import CosmosClient
import os
import json

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

endpoint = os.environ["COSMOS_ENDPOINT"]
account_key = os.environ["COSMOS_KEY"]
id = "1"
client = CosmosClient(endpoint, account_key)

@app.route(route="visitor_count")
def visitor_count(req: func.HttpRequest) -> func.HttpResponse:

    database_name = client.get_database_client("ResumeDB")
    container_name = database_name.get_container_client("Counter")

    counter = container_name.read_item(id, id)

    if not counter:
        return func.HttpResponse(
            "Count item missing",
            status_code=400  # Bad Request
        )
    counter['count'] = counter['count'] + 1

    container_name.upsert_item(body=counter)
    item_json = json.dumps(counter, indent=2)

    # Return the item as a JSON response
    return func.HttpResponse(
        body=item_json, 
        mimetype='application/json',
        status_code=200
    )