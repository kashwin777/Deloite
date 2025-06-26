def lambdaMap(arr):
    return list(map(lambda row: list(map(lambda x: x * x, filter(lambda x: x > 0, row))), arr))

# Sample Input
arr = [[-1, 1, 2, -2, 6], [3, 4, -5]]
result = lambdaMap(arr)
for row in result:
    print(*row)
class Color:
    def __init__(self, r: int, g: int, b: int):
        for val, name in [(r, 'r'), (g, 'g'), (b, 'b')]:
            if not (0 <= val <= 255):
                raise ValueError(f"Value of {name} should be between 0 and 255")
        self.r = r
        self.g = g
        self.b = b

    def __repr__(self) -> str:
        return f"Color: #{self.r:02x}{self.g:02x}{self.b:02x}"

# Test
try:
    print(Color(10, 100, 1))        # Color: #0a6401
    print(Color(-1, 10, 255))       # Raises ValueError
except ValueError as e:
    print(e)
def process_data(obj):
    if hasattr(obj, 'process') and callable(getattr(obj, 'process')):
        return obj.process()
    return None

class MyClass:
    pass

obj = MyClass()

# Example query simulation
queries = [1, 2, 3, 4]
for q in queries:
    if q == 1:
        obj.process = "not_callable"
    elif q == 2:
        obj.process = lambda: "function_str"
    elif q == 3:
        def process(): return 1
        obj.process = process
    elif q == 4:
        if hasattr(obj, 'process'):
            del obj.process
    print(process_data(obj))
def compute(*args, **kwargs):
    op = kwargs.get("operation")
    if op == "add":
        return sum(args)
    elif op == "max":
        return max(args)
    elif op == "min":
        return min(args)
    return -1

def partial(func, *args, **kwargs):
    def wrapper(*more_args, **more_kwargs):
        return func(*(args + more_args), **{**kwargs, **more_kwargs})
    return wrapper

# Sample Test
result = partial(compute, operation="min")
result = partial(result, 4, 8, 5)
result = partial(result, 1)
print(result(2))  # Output: 1
