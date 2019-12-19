# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:light
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.4
#   kernelspec:
#     display_name: Python3 - IPythonKernel
#     language: python
#     name: ipython_ipythonkernel
# ---

# +
# %load_ext lab_black
# %load_ext sql

# %sql postgres://localhost:3333/pfocr
# -

a = 1
print(a)

# +
# Python program to demonstrate
# basic array characteristics
import numpy as np

# Creating array object
arr = np.array([[1, 2, 3], [4, 2, 5]])
print(arr)

# + {"language": "sql"}
# SELECT id FROM xrefs LIMIT 2;

# + {"magic_args": "postgres://localhost:3333/pfocr", "language": "sql"}
# SELECT id FROM xrefs LIMIT 2;
# -


