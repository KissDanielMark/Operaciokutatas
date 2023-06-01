set TERMEKEK;
set HONAPOK;

param kereslet{TERMEKEK, HONAPOK};


param max_gyartas_havonta{TERMEKEK};
param zaro_raktar{TERMEKEK};

param tarolasi_koltseg{TERMEKEK};
param kezdeti_raktar{TERMEKEK};
param gyartasi_koltsegek{TERMEKEK};

var gyartas {TERMEKEK, HONAPOK} >= 0;
var tarolas {TERMEKEK, HONAPOK} >= 0;

minimize koltseg: sum {i in TERMEKEK, j in HONAPOK}(
	gyartasi_koltsegek[i]*gyartas[i,j]	
	+ 
	tarolasi_koltseg[i]*tarolas[i,j]
);

subject to max_gyartas {i in TERMEKEK, j in HONAPOK}:  gyartas[i,j] <= max_gyartas_havonta[i];

subject to raktar_kezdes{i in TERMEKEK}: gyartas[i,1] = kereslet[i,1] + tarolas[i,1];
subject to raktar_kozben {i in TERMEKEK, j in HONAPOK: 1<j<6}: tarolas[i, j-1] + gyartas[i,j] = kereslet[i,j] + tarolas[i,j];
subject to raktar_vegen{i in TERMEKEK}: gyartas[i,6] = kereslet[i,6] + zaro_raktar[i] - tarolas[i, 5];
subject to rraktar_zarolas{i in TERMEKEK}: tarolas[i,6] = zaro_raktar[i];