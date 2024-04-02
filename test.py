from matplotlib import pyplot as plt
import numpy as np

def f(x):
  return x

x = np.linspace(-10, 10, 500) # start, stop, num
plt.plot(x, f(x))
plt.grid()

plt.axhline(0, color="black")
plt.axvline(0, color="black")

plt.xlabel("x")
plt.ylabel("y")
plt.title("Plot")
plt.show()
