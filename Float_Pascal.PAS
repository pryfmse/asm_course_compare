Program test;
var
i: word;
a, b: real;

begin
    a := 1.0;
    b := 1.0;

    for i := 0 to 65535 do
        a := a + b;

    a := 1.0;

    for i := 0 to 65535 do
        a := a * b;

    for i := 0 to 65535 do
        a := a / b;

    for i := 0 to 65535 do
    begin
        a := a + b;
        a := a + b;
        a := a + b;
        a := a + b;
        a := a + b;

        a := a * b;
        a := a * b;

        a := a / b;
    end;

end.