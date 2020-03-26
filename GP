{В книге имеется N страниц. Определить, сколько всего цифр понадобится для нумерации страниц (при N=10000).}

type  // Создаём список
TSpisok=^PSpisok;
PSpisok = record 
i:integer;
next:TSpisok;// Указатель на следующий элемент
prev:TSpisok;// на предыдущий
end;



procedure summa(var head:TSpisok;tail:TSpisok; num:integer) ; // прибавление к большому числу одноразрядное число
var
help:TSpisok; // вспомогательный двусвязный список
begin
if head <>nil then // Если список не пустой,смотри в конце
begin


 if tail^.i + num < 10 then //Если сумма одноразрядного числа и последнего разряда большего числа меньше 10, то 
      tail^.i := tail^.i + num // прибавляем одноразрядное число к последнему разряду большего числа
    else //Если сумма одноразрядного числа и последнего разряда большего числа больше 10, то 
      begin
        tail^.i := (tail^.i + num) mod 10; // последний разряд большего числа равен последнему раздряду суммы последнего разряда большего числа и одноразрядного числа
        num:=1; // держим в уме 1 (как сложение столбиком)
        if tail^.prev = nil then// Если нужно добавляем новый разряд
          begin
            new(tail^.prev);
            help := tail;
            tail := tail^.prev;
            tail^.next := help;
            tail^.prev:=nil;
            head:=tail;
          end
        else
          tail := tail^.prev;//переходим на предыдущий и начинаем рекурсию суммы
        summa(head,tail,num);
        end;


end;



end;



procedure vivodhead(head: tspisok);
begin
  writeln;
  while head <> nil do
  begin
    write(head^.i:5);
    head := head^.next;   
  end;
  writeln;
end;



procedure razryad(n:integer; var p:integer);
begin
p:=0; //Равна нулю
while n<>0 do //Пока n не равно 0
begin
n:=n div 10; //Н делим на 10, чтобы узнать разрядность (что-то такое)
p:=p+1; //
end;
end;




var
head,tail:TSpisok;
n,p:integer;
BEGIN


new(head);//делаем список не пустым 
head^.i:=0;//изначально 0
head^.prev:=nil;
head^.next:=nil;
tail:=head;


for n:=1 to 10000 do
begin
razryad(n,p);
summa(head,tail,p);

end;
vivodhead(head);

END.
