Program test;
var 
i: word;
a, b: longint;

begin
    a := 1;
    b := 1;

    for i := 0 to 65535   do
        a := a + b;

    a := 1;

    for i := 0 to 65535 do
        a := a * b;

    for i := 0 to 65535 do
        a := a div b;

    for i := 0 to 65535 do
    begin
        a := a + b;
        a := a + b;
        a := a + b;
        a := a + b;
        a := a + b;

        a := a * b;
        a := a * b;

        a := a div b;
    end;

end.