
class LCGennerator:
    def __init__(self, x, n, a = 5**5, m = 2**13 - 1, c = 3 ) -> None:
        self.start_value = x
        self.number = n
        self.a = a
        self.m = m
        self.c = c

    def find_period(self):
        count = 0
        seen = set()
        x = self.start_value
        while x not in seen:
            seen.add(x)
            x = (self.a* x + self.c) % self.m
            count += 1
        return count

    def generate_sequence(self):
        def f(X):
            return (self.a * X + self.c) % self.m
        U = []
        X = self.start_value
        for _ in range(self.number):
            X = f(X)
            U += [X]

        return U




