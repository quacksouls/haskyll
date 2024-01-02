--------------------------------------------------------------------------------
-- MIT License
--
-- Copyright (C) 2024 Duck McSouls <quacksouls [AT] gmail [DOT] com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------------------------------

import Text.Printf

-- | Brute force method to generate primitive Pythagorean triples.
brute :: Integer -> [[Integer]]
brute n = do
    let ell = [1 .. n] :: [Integer]
    let triple = sequence [ell, ell, ell]
    filter (\[x, y, z] -> isppt x y z) triple

-- | Euclid's method for generating primitive Pythagorean triples.
euclid :: Integer -> [[Integer]]
euclid n = do
    let ell = [1 .. n] :: [Integer]
    let pair = filter (\[x, y] -> x > y && gcd x y == 1) $ sequence [ell, ell]
    let candidate = map (\[m, n] -> [m ^ 2 - n ^ 2, 2 * m * n, m ^ 2 + n ^ 2]) pair
    let triple = filter (\[x, y, z] -> x <= 100 && y <= 100 && z <= 100) candidate
    filter (\[x, y, z] -> isppt x y z) triple

-- | Whether a triple of numbers is coprime.
isCoprime :: Integral a => a -> a -> a -> Bool
isCoprime x y z = gcd x y == 1 && gcd x z == 1 && gcd y z == 1

-- | Whether a triple of numbers form a primitive Pythagorean triple.
isppt :: Integral a => a -> a -> a -> Bool
isppt x y z = isPythagoreanTriple x y z && isCoprime x y z

-- | Whether a triple of numbers form a Pythagorean triple.
isPythagoreanTriple :: Integral a => a -> a -> a -> Bool
isPythagoreanTriple x y z = x ^ 2 + y ^ 2 == z ^ 2

-- | Generate primitive Pythagorean triples at most 100.
main = do
    let ellBrute = brute 100
    let ellEuclid = euclid 100
    printf "%s\n" $ show ellBrute
    printf "%s\n" $ show ellEuclid