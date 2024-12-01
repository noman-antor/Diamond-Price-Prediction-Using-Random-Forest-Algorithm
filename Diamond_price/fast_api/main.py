import pickle

import uvicorn
from fastapi import FastAPI, File, UploadFile
import numpy as np
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

class diamond_values(BaseModel):
    carat:float
    cut:int
    color:int
    clarity:int
    depth:float
    table:float
    x:float
    y:float
    z:float

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://127.0.0.1:4350",
    "http://192.168.0.101"

]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

open_model = open("C:/Users/User/Documents/Diamond_price/model/diamond_model.pkl", "rb")
model = pickle.load(open_model)

open_scale = open("C:/Users/User/Documents/Diamond_price/model/diamond_scaler.pkl", "rb")
scaler = pickle.load(open_scale)

@app.post("/diamond_price")
async  def diamond_price(take:diamond_values):
    feature=np.array([[take.carat,
                     take.cut,
                     take.color,
                     take.clarity,
                     take.depth,
                     take.table,
                     take.x,
                     take.y,
                     take.z]])
    scaled_feat=scaler.transform(feature)
    pred=model.predict(scaled_feat)[0]
    return pred

#array[[18.21,189.56]];

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)
