/* Map */
makeMap :-
	asserta(item(block,5,13)),
	asserta(item(block,8,0)),
	asserta(item(block,14,0)),
	asserta(item(block,0,4)),
	asserta(item(block,0,6)),
	asserta(item(block,0,11)),
	asserta(item(block,0,13)),
	asserta(item(block,8,2)),
	asserta(item(block,8,3)),
	asserta(item(block,8,4)),
	asserta(item(block,7,4)),
	asserta(item(block,6,4)),
	asserta(item(block,2,4)),
	asserta(item(block,1,4)),
	asserta(item(block,14,1)),
	asserta(item(block,14,3)),
	asserta(item(block,14,4)),
	asserta(item(block,14,5)),
	asserta(item(block,14,6)),
	asserta(item(block,14,7)),
	asserta(item(block,15,4)),
	asserta(item(block,19,4)),
	asserta(item(block,20,4)),
	asserta(item(block,1,6)),
	asserta(item(block,6,6)),
	asserta(item(block,7,6)),
	asserta(item(block,8,6)),
	asserta(item(block,8,7)),
	asserta(item(block,8,8)),
	asserta(item(block,8,10)),
	asserta(item(block,8,11)),
	asserta(item(block,1,11)),
	asserta(item(block,2,11)),
	asserta(item(block,6,11)),
	asserta(item(block,7,11)),
	asserta(item(block,8,11)),
	asserta(item(block,1,13)),
	asserta(item(block,2,13)),
	asserta(item(block,6,13)),
	asserta(item(block,7,13)),
	asserta(item(block,8,13)),
	asserta(item(block,8,14)),
	asserta(item(block,8,15)),
	asserta(item(block,8,16)),
	asserta(item(block,8,18)),
	asserta(item(block,8,19)),
	asserta(item(block,8,20)),
	asserta(item(block,14,9)),
	asserta(item(block,14,10)),
	asserta(item(block,14,11)),
	asserta(item(block,14,12)),
	asserta(item(block,14,14)),
	asserta(item(block,14,15)),
	asserta(item(block,15,10)),
	asserta(item(block,16,10)),
	asserta(item(block,17,10)),
	asserta(item(block,19,10)),
	asserta(item(block,20,10)),
	asserta(item(block,15,15)),
	asserta(item(block,16,15)),
	asserta(item(block,17,15)),
	asserta(item(block,19,15)),
	asserta(item(block,20,15)),
	asserta(item(block,15,16)),
	asserta(item(block,15,18)),
	asserta(item(block,15,19)),
	asserta(item(block,15,20)).

random_member(D, A) :-
    length(A, B),
    random(0, B, C),
    nth0(C, A, D).

initEnemy(N) :-
 (N == 0),
  !.

initEnemy(N) :-
 random(5, 20, Pow),
 random(1, 21, X),
 random(1, 21, Y),
 random_member(D, [ayat_kursi,baca_Quran,tahajud,madurasa,eastco,jamuran,sedap_malam,zamZam,thaiTea,air_doa,radar]),
 makeEnemy(N, Pow, D, X, Y),
 N1 is (N-1),
 initEnemy(N1).
/* Enemy */
makeEnemy(Id, Power, Item, X, Y) :-
	asserta(enemy(Id, Power, Item, X, Y)).

moveEnemy :-
  	enemy(_, _, _, X, Y),
  	player(_, _, _, _, _, X, Y),
  	!, fail.

moveEnemy :-
   retract(enemy(Id, Power, Item, X, Y)),
   moveX(Id, Power, Item, X, Y).

moveX(Id, Power, Item, X, Y) :-
   X =:= 1, !,
   random(0,2,XX),
   NewX is (X+XX),
   moveY(Id, Power, Item, NewX,Y).

moveX(Id, Power, Item, X, Y) :-
   X =:= 20 ,!,
   random(-1,1,XX),
   NewX is (X+XX),
   moveY(Id, Power, Item, NewX,Y).

moveX(Id, Power, Item, X, Y) :-
   random(-1,2,XX),
   NewX is (X+XX),
   moveY(Id, Power, Item, NewX,Y).

moveY(Id, Power, Item, X, Y) :-
   Y =:= 1, !,
   random(0,2,YY),
   NewY is (Y+YY),
   asserta(enemy(Id, Power, Item, X, NewY)).

moveY(Id, Power, Item, X, Y) :-
   Y =:= 20 ,!,
   random(-1,1,YY),
   NewY is (Y+YY),
   asserta(enemy(Id, Power, Item, X, NewY)).

moveY(Id, Power, Item, X, Y) :-
   random(-1,2,YY),
   NewY is (Y+YY),
   asserta(enemy(Id, Power, Item, X, NewY)).

/* Player */
makePlayer(Health, Hunger, Thirst, Weapon, Inventory, X, Y) :-
	asserta(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)).

editHealth(Amount) :-
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	New_Health is (Health + Amount),
	asserta(player(New_Health, Hunger, Thirst, Weapon, Inventory, X, Y)).

editHunger(Amount) :-
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	New_Hunger is (Hunger + Amount),
	asserta(player(Health, New_Hunger, Thirst, Weapon, Inventory, X, Y)).

editThirst(Amount) :-
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	New_Thrist is (Thirst + Amount),
	asserta(player(Health, Hunger, New_Thrist, Weapon, Inventory, X, Y)).

editLocation(X, Y) :-
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, Xnow, Ynow)),
	X1 is Xnow+X,
	Y1 is Ynow+Y,
	asserta(player(Health, Hunger, Thirst, Weapon, Inventory, X1, Y1)).

editWeapon(ID) :-
	retract(player(Health, Hunger, Thirst, _, Inventory, X, Y)),
	asserta(player(Health, Hunger, Thirst, ID, Inventory, X, Y)).

editInventory([H|T]) :-
	(H == none), !,
	retract(player(Health, Hunger, Thirst, Weapon, _, X, Y)),
	asserta(player(Health, Hunger, Thirst, Weapon, T, X, Y)).

editInventory(New_Inventory) :-
	retract(player(Health, Hunger, Thirst, Weapon, _, X, Y)),
	asserta(player(Health, Hunger, Thirst, Weapon, New_Inventory, X, Y)).

/* Item */

/* List of ID
0 water
1 - 3 medicine
4 - 6 food
7 - 9 water
10 >= item lainnya */

nama(0,ayat_kursi).
nama(1,baca_Quran).
nama(2,tahajud).
nama(3,madurasa).
nama(4,eastco).
nama(5,jamuran).
nama(6,sedap_malam).
nama(7,zamZam).
nama(8,thaiTea).
nama(9,air_doa).
nama(10,radar).

checkItem(_, [], []) :- !,fail.
checkItem(Item, [Head|Tail], Tail) :-
	(Item == Head),!.
checkItem(Item, [Head|Tail], [Head|Y]) :-
	checkItem(Item, Tail, Y).

posisiItem(Item) :-
	item(Item, X, Y), player(_, _, _, _, _, X, Y),!.

weapon(ayat_kursi).

medicine(baca_Quran, 30).
medicine(tahajud, 20).
medicine(madurasa, 10).

food(eastco, 30, 0).
food(jamuran,20,-5).
food(sedap_malam,10,-10).

drink(zamZam, 30).
drink(thaiTea, 20).
drink(air_doa,10).

makeItem(Id, X, Y) :-
	nama(Id, Nama),
	asserta(item(Nama,X,Y)).

initMedicine(0) :- !.

initMedicine(N) :-
	random(0, 20, X),
	random(0, 20, Y),
	random(1, 3, Id),
	makeItem(Id,X,Y),
	N1 is (N - 1),
	initMedicine(N1).

initFood(0) :- !.

initFood(N) :-
	random(0, 20, X),
	random(0, 20, Y),
	random(4, 6, Id),
	makeItem(Id,X,Y),
	N1 is (N - 1),
	initFood(N1).

initWater(0) :- !.

initWater(N) :-
	random(0, 20, X),
	random(0, 20, Y),
	random(7, 9, Id),
	makeItem(Id,X,Y),
	N1 is (N - 1),
	initWater(N1).

initWeapon(0) :- !.

initWeapon(N) :-
	random(0,20,X),
	random(0,20,Y),
	makeItem(0, X,Y),
	N1 is (N - 1),
	initWeapon(N1).

take(Item) :-
  	posisiItem(Item),
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	retract(item(Item,X,Y)),
	write('You took '), write(Item), nl,
	asserta(player(Health, Hunger, Thirst, Weapon, [Item|Inventory], X, Y)), !,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.

drop(Item) :-
	player(_, _, _, _, Inventory, _, _),
	checkItem(Item, Inventory, New_Inventory),!,
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	asserta(item(Item,X,Y)),
	write('You dropped '), write(Item), nl,
	asserta(player(Health, Hunger, Thirst, Weapon, New_Inventory, X, Y)), !,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.

use(Item) :-
	player(_, _, _, _, Inventory, _, _),
	checkItem(Item, Inventory, New_Inventory),
	medicine(Item,Health),!,
  	editInventory(New_Inventory),
	editHealth(Health),
	write('Your health is raised by '), write(Health), nl,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.

use(Item) :-
	player(_, _, _, _, Inventory, _, _),
	checkItem(Item, Inventory, New_Inventory),
	food(Item,Hunger,Poison),!,
  	editInventory(New_Inventory),
	editHunger(Hunger),
	editHealth(Poison),
	write('Your hunger is raised by '), write(Hunger), nl,
	write('Your health is poisoned by '), write(Poison), nl,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.

use(Item) :-
	player(_, _, _, _, Inventory, _, _),
	checkItem(Item, Inventory, New_Inventory),
	drink(Item,Thirst),!,
  	editInventory(New_Inventory),
	editThirst(Thirst),
	write('Your thirst is raised by '), write(Thirst), nl,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.

use(Item) :-
	player(_, _, _, Weapon, Inventory, _, _),
	checkItem(Item, Inventory, New_Inventory),
	weapon(Item),!,
  	editInventory([Weapon|New_Inventory]),
	editWeapon(Item),
	write('You equiped with ayat_kursi'), nl,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !, moveEnemy.


/* Main Rule */
start :-
	makePlayer(100,100,100 , none, [], 1, 1),
	makeMap,
	initEnemy(10),
	asserta(enemy(999,999,egg,999,999)),
	asserta(totalEnemy(11)),
	initFood(10),
	initWater(10),
	initWeapon(10),
	initMedicine(10),
	write('"DOR!!, Bunyi apa itu? Dimanakah saya? Kenapa disini gelap?""'), nl,
	write('Anda telah terbangun di ruangan yang cukup familiar'), nl,
	write('Sepertinya Anda telah terbangun di sekre 2 HMIF'), nl,
	write('Ingatan yang Anda punya hanyalah kenangan ketika dilantik SPARTA'), nl,
 	write('KREK!!, Tiba-tiba ada seseorang muncul dari kegelapan'), nl,
  	write('"Aku adalah sang penakluk tempat ini, akulah penunggu tempat ini"'), nl,
  	write('"Kamu terperangkap di Labtek V, Jika kamu ingin selamat carilah kunci Labtek ini"'), nl,
  	write('"Tapi dimanakah aku dapat kunci tersebut?"'), nl,
  	write('"Labtek ini berhantu, Kau harus membunuh seluruh hantu di tempat ini!"'), nl,
  	write('"Tapi bagaimana??"'), nl,
  	write('DES!! Tiba-tiba penghuni hilang dari pandangan'), nl,
  	write('Carilah kunci tersebut untuk keluar dari Labtek ini !!'), nl,
  	nl, nl,
  	write('Available Commands   :   '), nl,
  	write('help.            -- untuk menampilkan command yang tersedia'), nl,
  	write('n.               -- untuk bergerak ke utara'), nl,
  	write('w.               -- untuk bergerak ke barat'), nl,
  	write('s.               -- untuk bergerak ke selatan'), nl,
  	write('e.               -- untuk bergerak ke timur'), nl,
  	write('look.            -- untuk melihat sekitar'), nl,
  	write('take(Object).    -- untuk mengambil objek'), nl,
  	write('drop(Object).    -- untuk melepaskan objek'), nl,
  	write('use(Object).     -- untuk menggunakan objek'), nl,
  	write('attack.          -- untuk menyerang musuh'), nl,
  	write('status.          -- untuk menampilkan status pemain'), nl,
  	write('save(Filename)   -- untuk menyimpan permainan'), nl,
  	write('load(Filename)   -- untuk meneruskan permainan'), nl,
  	write('quit             -- untuk keluar dari permainan'), nl,
  	nl, nl,
  	write('Legends          :   '), nl,
  	write('M    =   Medicine'), nl,
  	write('F    =   Food'), nl,
  	write('W    =   Water'), nl,
  	write('#    =   Weapon'), nl,
  	write('P    =   Player') , nl,
  	write('E    =   Enemy') , nl,
  	write('-    =   Accessible') , nl,
  	write('X    =   Inaccessible') , nl,
	repeat,
	nl, write('>> '),
	read(X),
	isInput(X),
	call(X),
	cekPlayer,
	end.

help :-
    write('n.               -- untuk bergerak ke utara'), nl,
    write('w.               -- untuk bergerak ke barat'), nl,
    write('s.               -- untuk bergerak ke selatan'), nl,
    write('e.               -- untuk bergerak ke timur'), nl,
    write('look.            -- untuk melihat sekitar'), nl,
    write('take(Object).    -- untuk mengambil objek'), nl,
    write('drop(Object).    -- untuk melepaskan objek'), nl,
    write('use(Object).     -- untuk menggunakan objek'), nl,
    write('attack.          -- untuk menyerang musuh'), nl,
    write('status.          -- untuk menampilkan status pemain'), nl,
    write('save(Filename)   -- untuk menyimpan permainan'), nl,
    write('load(Filename)   -- untuk meneruskan permainan'), nl,
    write('quit.            -- untuk keluar dari permainan'), nl, !,
	player(_, _, _, _, Inventory, _, _),
	checkItem(radar, Inventory, _),
    write('map.             -- untuk melihat peta secara keseluruhan'), nl.

isInput(n) :- !.
isInput(w) :- !.
isInput(s) :- !.
isInput(e) :- !.
isInput(map) :- !.
isInput(quit) :- !.
isInput(status) :- !.
isInput(take(_)) :- !.
isInput(drop(_)) :- !.
isInput(look) :- !.
isInput(use(_)) :- !.
isInput(attack) :- !.
isInput(save(_)) :- !.
isInput(loads(_)) :- !.
isInput(help) :- !.
isInput(listing(_)) :-
	write('NO CHEAT!!'), nl, !, halt.
isInput(_) :-
	write('YHA SALAH INPUT YHA!!'), nl, fail.

end :-
	totalEnemy(1),
	write('MENANG BOI AKHIRNYA KELUAR DARI LABTEK V!'), nl,!, halt.
end :-
	player(Health, _, _, _, _, _, _),
	(Health =< 0),write('YAELAH KALAH!'), nl, !, halt.
end :-
	player(_, Hunger, _, _, _, _, _),
	(Hunger =< 0),write('YAELAH KALAH!'), nl, !, halt.
end :-
	player(_, _, Thirst, _, _, _, _),
	(Thirst =< 0),write('YAELAH KALAH!'), nl, !, halt.

quit :-
	halt.

/* Move Player */
n :-
	player(_, _, _, _, _, X , Y),
	Ynow is Y - 1,
	item(block,X,Ynow),
	write('Jangan nabrak tembok'),
	nl, !.

n :-
	player(_, _, _, _, _, _, Ynow),
	(Ynow > 0),!,
	editLocation(0,-1),
	editHunger(-1),
	editThirst(-1),
	player(_,_,_,_,_,X,Y),
	moveEnemy,showNearby(X,Y),!.

n :-
	write('Jangan nabrak tembok'),
	nl, !.

s :-
	player(_, _, _, _, _, X , Y),
	Ynow is Y + 1,
	item(block,X,Ynow),
	write('Jangan nabrak tembok'),
	nl, !.

s :-
	player(_, _, _, _, _, _, Ynow),
	(Ynow =< 19),!,
	editLocation(0,1),
	editHunger(-1),
	editThirst(-1),
	player(_,_,_,_,_,X,Y),
	moveEnemy,showNearby(X,Y),!.

s :-
	write('Jangan nabrak tembok'),
	nl, !.

w :-
	player(_, _, _, _, _, X , Y),
	Xnow is X - 1,
	item(block,Xnow,Y),
	write('Jangan nabrak tembok'),
	nl, !.

w :-
	player(_, _, _, _, _, Xnow, _),
	(Xnow > 0),!,
	editLocation(-1,0),
	editHunger(-1),
	editThirst(-1),
	player(_,_,_,_,_,X,Y),
	moveEnemy,showNearby(X,Y),!.

w :-
	write('Jangan nabrak tembok'),
	nl, !.

e :-
	player(_, _, _, _, _, X , Y),
	Xnow is X + 1,
	item(block,Xnow,Y),
	write('Jangan nabrak tembok'),
	nl, !.

e :-
	player(_, _, _, _, _, Xnow, _),
	(Xnow =< 19),!,
  	editLocation(1,0),
	editHunger(-1),
	editThirst(-1),
	player(_,_,_,_,_,X,Y),
	moveEnemy,showNearby(X,Y),!.

e :-
	write('Jangan nabrak tembok'),
	nl.

/* Print Player Status */
status :-
	player(Health, Hunger, Thirst, Weapon, Inventory, _, _),
	write('Health : '),write(Health), nl,
	write('Hunger : '),write(Hunger), nl,
	write('Thirst : '),write(Thirst), nl,
	write('Weapon : '),write(Weapon), nl,
	write('Inventory : '),write(Inventory), nl.

/* Check is Enemy Nearby */
enemyAvailable(Id) :-
	player(_, _, _, _, _, X, Y),
	enemy(Id, _, _, X, Y),!.

/* Attack Enemy */
attack :-
	enemyAvailable(Id),
	player(_, _, _, Current, _, X, Y),
	enemy(Id,Power,_,X,Y),
	(Current == none), !,
	write('You do not have any weapon used '), nl,
	editHealth(-Power),
	write('You have took damage '),
	write(Power),nl,
	!, moveEnemy.

attack :-
	enemyAvailable(Id), !,
	retract(enemy(Id,Power,Item,X,Y)),
	retract(totalEnemy(N)),
	Nnew is N - 1,
	asserta(totalEnemy(Nnew)),
	asserta(item(Item,X,Y)),
  	editHealth(-Power),
	write('You have took damage '),
	write(Power),nl,
	!, moveEnemy.

attack :-
	\+enemyAvailable(_),
	write('Enemy not found'), nl.

/* cek player condition */
cekPlayer :-
	player(Health, Hunger, Thirst, Weapon, Inventory, X, Y),
	(Health > 100),
	New_Health is 100,
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	asserta(player(New_Health, Hunger, Thirst, Weapon, Inventory, X, Y)).

cekPlayer :-
	player(Health, Hunger, Thirst, Weapon, Inventory, X, Y),
	(Hunger > 100),
	New_Hunger is 100,
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	asserta(player(Health, New_Hunger, Thirst, Weapon, Inventory, X, Y)).

cekPlayer :-
	player(Health, Hunger, Thirst, Weapon, Inventory, X, Y),
	(Thirst > 100),
	New_Thirst is 100,
	retract(player(Health, Hunger, Thirst, Weapon, Inventory, X, Y)),
	asserta(player(Health, Hunger, New_Thirst, Weapon, Inventory, X, Y)).

cekPlayer.

/* cek location */
cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X =< 7),
	(Y =< 3),
	write('You are in Sekre 2 HMIF, the south is BasDat, the east is GaIb'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X =< 7),
	(Y >= 6),
	(Y =< 11),
	write('You are in BasDat, the south is 7602, the east is IRK, the north is 7602'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X =< 7),
	(Y >= 13),
	write('You are in 7602, the north is BasDat, the east is toilet'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X >= 15),
	(X =< 20),
	(Y =< 3),
	write('You are in GaIb, the south is IRK, the east is Sekre 2 HMIF'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X >= 15),
	(X =< 20),
	(Y >= 4),
	(Y =< 10),
	write('You are in IRK, the south is SisTer, the west is BasDat, the north is GaIb'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X >= 15),
	(X =< 20),
	(Y >= 10),
	(Y =< 15),
	write('You are in SisTer, the south is toilet, the west is BasDat, the north is IRK'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X >= 15),
	(X =< 20),
	(Y > 15),
	write('You are in toilet, the east is 7602, the north is SisTer'), nl, !.

cekLocation(X,Y) :-
	player(_,_,_,_,_,X,Y),
	(X >= 9),
	(X =< 13),
	(Y >= 0),
	(Y =< 20),
	write('You are in the alley'), nl, !.

/* cek item/enemy nearby */
cekItemNearby(X,Y) :-
 	item(block,X,Y), !.

cekItemNearby(X,Y) :-
	item(Nama,X,Y),
	write('You see a ') , write(Nama), write(' nearby'), nl, !.

cekItemNearby(_,_).

cekEnemyNearby(X,Y) :-
	enemy(_,_,_,X,Y),
	write('You see an enemy nearby') , nl, !.

cekEnemyNearby(_,_).

showNearby(X,Y) :-
	cekLocation(X,Y),
	Xprec is X - 1,
	Yprec is Y - 1,
	Xsucc is X + 1,
	Ysucc is Y + 1,
	cekItemNearby(Xprec,Yprec),
	cekEnemyNearby(Xprec,Yprec),
	cekItemNearby(X,Yprec),
	cekEnemyNearby(X,Yprec),
	cekItemNearby(Xsucc,Yprec),
	cekEnemyNearby(Xsucc,Yprec),
	cekItemNearby(Xprec,Y),
	cekEnemyNearby(Xprec,Y),
	cekItemNearby(X,Y),
	cekEnemyNearby(X,Y),
	cekItemNearby(Xsucc,Y),
	cekEnemyNearby(Xsucc,Y),
	cekItemNearby(Xprec,Ysucc),
	cekEnemyNearby(Xprec,Ysucc),
	cekItemNearby(X,Ysucc),
	cekEnemyNearby(X,Ysucc),
	cekItemNearby(Xsucc,Ysucc),
	cekEnemyNearby(Xsucc,Ysucc).

/* cek print */
cekBlock(X, Y) :-
	item(block,X,Y),
	write('X'), !.
cekEnemy(X, Y) :-
	enemy(_, _, _, X, Y),!,
	write('E').
cekMedicine(X, Y) :-
	item(Id, X, Y),
	medicine(Id, _),!,
	write('M').
cekFood(X, Y) :-
	item(Id, X, Y),
	food(Id, _, _),!,
	write('F').
cekWater(X, Y) :-
	item(Id, X, Y),
	drink(Id, _),!,
	write('W').
cekWeapon(X, Y) :-
	item(Id, X, Y),
	weapon(Id),!,
	write('#').
cekPlayer(X, Y) :-
	player(_, _, _, _, _, X, Y),!,
	write('P').

cekAll(_,-1) :-
	write('#').
cekAll(_,21) :-
	write('#').
cekAll(-1,_) :-
	write('#').
cekAll(21,_) :-
	write('#').
cekAll(X,Y) :-
	cekBlock(X,Y),!.
cekAll(X,Y) :-
	cekEnemy(X,Y),!.
cekAll(X,Y) :-
	cekMedicine(X,Y),!.
cekAll(X,Y) :-
	cekFood(X,Y),!.
cekAll(X,Y) :-
	cekWater(X,Y),!.
cekAll(X,Y) :-
	cekWeapon(X,Y),!.
cekAll(X,Y) :-
	cekPlayer(X,Y),!.
cekAll(_,_) :-
	write('-').

printMap(X, Y, _, Xlast, Ylast) :-
	(X =:= Xlast+1),
	(Y =:= Ylast),!.

printMap(X, Y, Xinit, Xlast, Ylast) :-
	(X =:= Xlast+1),!,
	nl,
	Y1 is Y+1,
	printMap(Xinit, Y1, Xinit, Xlast, Ylast).

printMap(X, Y, Xinit, Xlast, Ylast) :-
	cekAll(X,Y),
	X1 is X+1,
	printMap(X1, Y, Xinit, Xlast, Ylast).

/* Print Minimap */
look :-
  	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power),!,
  	player(_, _, _, _, _, X, Y),
	X1 is X-1,
	Y1 is Y-1,
  	printMap(X1, Y1, X1, X+1, Y+1).


look :-
	player(_, _, _, _, _, X, Y),
	X1 is X-1,
	Y1 is Y-1,
  	printMap(X1, Y1, X1, X+1, Y+1),!.

/* Print All Map */
map :-
	player(_, _, _, _, Inventory, _, _),
	checkItem(radar, Inventory, _),
  	printMap(-1, -1, -1, 21, 21), !,
	enemyAvailable(Id),
	enemy(Id, Power, _, _, _),
	editHealth(-Power), !.

map :-
	write('You do not have any radar'), nl.

/* save & load game */
save(X) :-
	atom_concat(X,'.dat',F),
	write(F),
	tell(F),
	listing(player),
	listing(enemy),
	listing(item),
	told.

delall :-
	retract(enemy(_, _, _, _, _)),
	retract(player(_, _, _, _, _, _, _)),
	retract(item(_, _, _)).

loads(X) :-
	delall,
	atom_concat(X,'.dat',F),
	[F].
