#!/usr/bin/env python3

import os
import json
import sys

from flask import Flask, render_template

STATIC_PATH = "/static"
STATIC_FOLDER = "static"
TEMPLATE_FOLDER = "templates"

app = Flask(__name__,
            static_url_path = STATIC_PATH,
            static_folder = STATIC_FOLDER,
            template_folder = TEMPLATE_FOLDER)

@app.route('/')
def index_ca():
    return render_template("/index.html")

@app.route('/es')
def index_es():
    return render_template("/index-es.html")

@app.route('/en')
def index_en():
    return render_template("/index-en.html")
