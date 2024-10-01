"""Sample tests
tests are placed in this tests.py file inside the directory 'app' that holds project-level files (similalry, each django's app can have its own tests.py file that implements test cases.
alternatively, tests can be added as separate modules inside a sub-directory named 'tests' (if this approach was followed, ensure this directory has the '__init__.py' file to it can be treated as a pcakge.  Also ensure that you use either of the 2 approaches for organizing test cases but not both simultaneously!
"""

from django.test import SimpleTestCase

from app import calc

class CalcTests(SimpleTestCase):
    """Test the calc module."""

    # test case method names must start with "test_" to be picked up my django's "manage.py test" command
    def test_add_numbers(self):
        """Test adding numbers together."""

        res = calc.add(5, 6)

        self.assertEqual(res, 11)


    def test_subtract_numbers(self):
        """Test subtracting numbers."""

        res = calc.subtract(10, 15)

        self.assertEqual(res, 5)

