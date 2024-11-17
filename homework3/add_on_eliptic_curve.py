
class WrongArgumentError(Exception):
    def __init__(self, message):
        super().__init__(message)

## We assume it's y^2 = x^3 + ax + b
class EllipticCurve:
    tolerance = 0.0003
    
    def __init__(self, a, b):
        self.a = a  # Coefficient 'a' in the curve equation
        self.b = b  # Coefficient 'b' in the curve equation

    def point_addition(self, P, Q):

        if not (self.is_on_curve(P) and self.is_on_curve(Q)):
            raise WrongArgumentError('Points are not on the curve')

        if P == (None, None):
            return Q
        if Q == (None, None):
            return P
        
        xp, yp = P
        xq, yq = Q

        if P == Q:
            if yp == 0:  
                return (None, None)  
            lamb = (3 * xp ** 2 + self.a) / (2 * yp)
        else:
            if xp == xq:  
                return (None, None)  
            lamb = (yq - yp) / (xq - xp)

        xr = lamb ** 2 - xp - xq
        yr = lamb * (xp - xr) - yp

        return (xr, yr)
    
    def is_on_curve(self, P):
        xp, yp = P
        return abs(yp**2 - (xp**3 + self.a*xp + self.b)) <= self.tolerance

a = -7
b = 10
curve = EllipticCurve(a, b)

P = (1, 2)
Q = (3, 4)

try:
    result = curve.point_addition(P, P)
    print("P + Q = ", result)
except:
    print('Error')