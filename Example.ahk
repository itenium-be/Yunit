#Include <Yunit>
#Include <Yunit\Window>

Yunit.Use(Yunit.StdOut, YunitWindow).Test(NumberTestSuite, StringTestSuite)

class NumberTestSuite
{
    Begin()
    {
        this.x := 123
        this.y := 456
    }
    Test_Sum()
    {
        Yunit.assert(this.x + this.y == 579)
    }
    Test_Division()
    {
        Yunit.assert(this.x / this.y < 1)
        Yunit.assert(this.x / this.y > 0.25)
    }
    Test_Multiplication()
    {
        Yunit.assert(this.x * this.y == 56088)
    }
    End()
    {
        this.remove("x")
        this.remove("y")
    }
    class Negatives
    {
        Begin()
        {
            this.x := -123
            this.y := 456
        }
        Test_Sum()
        {
            Yunit.assert(this.x + this.y == 333)
        }
        Test_Division()
        {
            Yunit.assert(this.x / this.y > -1)
            Yunit.assert(this.x / this.y < -0.25)
        }
        Test_Multiplication()
        {
            Yunit.assert(this.x * this.y == -56088)
        }
        Test_Fails()
        {
            Yunit.assert(this.x - this.y == 0, "oops!")
        }
        End()
        {
            this.remove("x")
            this.remove("y")
        }
    }
}

class StringTestSuite
{
    Begin()
    {
        this.a := "abc"
        this.b := "cdef"
    }
    Test_Concat()
    {
        Yunit.assert(this.a . this.b == "abccdef")
    }
    Test_Substring()
    {
        Yunit.assert(SubStr(this.b, 2, 2) == "de")
    }
    Test_InStr()
    {
        Yunit.assert(InStr(this.a, "c") == 3)
    }
    End()
    {
        this.remove("a")
        this.remove("b")
    }
}