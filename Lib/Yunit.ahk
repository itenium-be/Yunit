#NoEnv

; Yunit.Test(class1, class2, ...)
class Yunit {
    __New() {
        FileDelete, Yunit.log
    }
    
    Test(classes*) { ; static method
        instance := new this()
        instance.results := {}
        instance.classes := classes
        while A_Index <= classes.MaxIndex() {
            cls := classes[A_Index]
            instance.current := A_Index
            instance.results[cls.__class] := obj := {}
            instance.TestClass(obj, cls)
        }
    }
    
    Update(category, test, result) {
        if IsObject(result) {
            details := ", At line #" result.line " " result.message
            result := "FAIL"
        }
        else
            result := "pass"
        FileAppend, %result%: %category%.%test%%details%`n, Yunit.log
    }
    
    TestClass(results, cls) {
        environment := new cls() ; calls __New
        for k,v in cls {
            if IsObject(v) && IsFunc(v) { ;test
                if k in Begin,End
                    continue
                if ObjHasKey(cls,"Begin") 
                && IsFunc(cls.Begin)
                    environment.Begin()
                try  {
                    v.(environment)
                    results[k] := 0
                }
                catch error {
                    results[k] := error
                }
                this.Update(cls.__class, k, results[k])
                if ObjHasKey(cls,"End")
                && IsFunc(cls.End)
                    environment.End()
            }
            else if IsObject(v)
            && ObjHasKey(v, "__class") ;category
                this.classes.Insert(++this.current, v)
        }
        environment := "" ; force call to __Delete immideately
    }
    
    assert(expr, message = "FAIL") {
        if (!expr)
            throw Exception(message, -1)
    }
}

; YunitGui.Test(class1, class2, ...)
class YunitGui extends Yunit { 
    __New() {
        ; create gui here
    }
    
    Update(category, test, result) { ; overload update function
        ; update gui here
    }
}