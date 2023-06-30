import requests
import json
from fastapi import FastAPI

app = FastAPI()

@app.get("/analyze")
def analyze_items():
    search_terms = ["chromecast", "google home", "apple tv"]  # Agregue aquí los términos de búsqueda
    
    for term in search_terms:
        # Realize la solicitud GET al servicio público para conseguir los resultados
        url = f"https://api.mercadolibre.com/sites/MLA/search?q={term}&limit=50"
        response = requests.get(url)
        search_results = response.json()
        
        # Itere sobre los resultados de búsqueda y realize la solicitud GET para cada ítem
        for result in search_results.get("results", []):
            item_id = result.get("id")
            item_url = f"https://api.mercadolibre.com/items/{item_id}"
            item_response = requests.get(item_url)
            item_data = item_response.json()
            
            # Extraje los datos y ecargue en el archivo plano
            item_title = item_data.get("title")
            item_price = item_data.get("price")
            item_condition = item_data.get("condition")
            # Se podrian agregar mas variables, depende de las solicitudes de busqueda
            
            with open("data/results.csv", "a") as file:
                file.write(f"{term},{item_id},{item_title},{item_price},{item_condition}\n")
    
    return {"mensaje": "Análisis finalizado"}

