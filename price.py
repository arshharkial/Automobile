import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dataset = pd.read_csv("Automobile_data.csv")
dataset.head()












x = dataset.iloc[ :, 1:-1].values
y = dataset.iloc[ :, -1].values


from sklearn.impute import SimpleImputer
impute = SimpleImputer(missing_values = "?", strategy = "mean")
x = impute.fit_transform(x)

from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.25, random_state = 0)

from sklearn.ensemble import RandomForestRegressor
regressor = RandomForestRegressor(n_estimators = 15)
regressor.fit(x_train, y_train)