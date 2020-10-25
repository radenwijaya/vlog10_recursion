program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, math;

function fac(f: int64) : int64;
var
  i: integer;
begin
  result:=1;

  for i := 1 to f do
    result:=result*i;
end;

const
  speed_test_depth = 20;
  precision_depth = 200;

function e_to_x_c(x: int64; max_depth: integer): double;
var
  d: integer;
begin
  result:=1;

  for d := 1 to max_depth do
    result:=result + power(x, d)/fac(d)
end;

function e_to_x_r(x, d, xp: double; max_depth: integer) : double;
begin
  if (d<=max_depth) then
    result:=xp * x/d + e_to_x_r(x, d+1, xp * x/d, max_depth)
  else
    result:=1;
end;

var
  Conventional, Recursive: TDateTime;
  i: integer;
begin
  Conventional:=now();
  for i := 1 to 1000000 do
    e_to_x_c(5, speed_test_depth);
  writeln(e_to_x_c(10, precision_depth):3:12, FormatDateTime(' s.zzz', now-Conventional));

  Recursive:=now();
  for i := 1 to 1000000 do
    e_to_x_r(5, 1, 1, speed_test_depth);
  writeln(e_to_x_r(10, 1, 1, precision_depth):3:12, FormatDateTime(' s.zzz', now-Recursive));

  readln;
end.
