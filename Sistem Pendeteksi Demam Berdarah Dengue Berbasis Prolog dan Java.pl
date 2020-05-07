%TUGAS BESAR PEMROGRAMAN DEKLARATIF
:- use_module(library(jpl)).
start :-sleep(0.2),
		write('|================================================================|'),nl,
		sleep(0.4),
		write("|                Sistem Deteksi Demam Berdarah Dengue            |"),nl,
		sleep(0.4),
		write('|================================================================|'),nl,

		interface2.
%Penerapan modul 1
    gejala(User,demam) :- verify(User,", Apakah Kamu Demam dengan derajat celsius yang tinggi (y/n) ?").

    gejala(User,nkepala) :- verify(User,", Apakah Kamu mengalami nyeri pada kepala(y/n) ?").

    gejala(User,nsendi) :- verify(User,", Apakah Kamu mengalami nyeri pada sendi, otot dan tulang (y/n) ?").

    gejala(User,nmata) :- verify(User,", Apakah Kamu mengalami nyeri pada bagian beakang mata (y/n) ?").

    gejala(User,nmakan) :- verify(User,", Apakah nafsu makanmu menurun(y/n) ?").

    gejala(User,mual) :- verify(User,", Apakah Kamu mual (y/n) ?").

    gejala(User,muntah) :- verify(User,", Apakah Kamu muntah(y/n) ?").

    gejala(User,tdarah) :- verify(User,", Apakah Tekanan darahmu menurun (y/n) ?").



    analisis(User,berpotensi_besar_positif_Demam_Berdarah_Dan_Sudah_Parah) :-
        gejala(User,demam),
        gejala(User,nkepala),
        gejala(User,nsendi),
        gejala(User,nmata),
        gejala(User,nmakan),
        gejala(User,muntah),
        gejala(User,tdarah).


     analisis(User,berpotensi_besar_positif_Demam_Berdarah) :-
        gejala(User,demam),
        gejala(User,nkepala),
        gejala(User,nsendi),
        gejala(User,nmakan),
        gejala(User,mual),
        gejala(User,muntah).

     analisis(User,berpotensi_sedang_positif_Demam_Berdarah) :-
        gejala(User,demam),
        gejala(User,nkepala),
        gejala(User,nsendi),
        gejala(User,nmata),
        gejala(User,nmakan).


     analisis(User,berpotensi_kecil_positif_Demam_Berdarah) :-
        gejala(User,demam),
        gejala(User,nsendi).




	analisis(_,"Tidak Diketahui. Jawaban anda kurang memenuhi dan kurang valid, sehingga tidak terdeteksi oleh sistem kami. mohon maaf").

     response(Reply) :-
        read(Reply),
        write(Reply),nl.

%penerapan modul 4 operasi Logika AND

    ask(User,Question) :-
	write(User),write(','),write(Question),


	interface(',',User,Question),
	write('Loading.'),nl,
	sleep(1),
	write('Loading..'),nl,
	sleep(1),
    nl.

:- dynamic yes/1,no/1.

%penerapan modul 2 manipulasi list dan modul 5 list of list

    count_gejala(analisis(dbd)).
    count_gejala(t(_,gjl,gjl),1).
    count_gejala(t(_,L,gjl),N) :- L = t(_,_,_), count_gejala(L,N).
    count_gejala(t(_,gjl,R),N) :- R = t(_,_,_), count_gejala(R,N).
    count_gejala(t(_,L,R),N) :- L = t(_,_,_), R = t(_,_,_),
    count_gejala(L,NL), count_gejala(R,NR), N is NL + NR.



verify(P,S) :-
   (yes(S)
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(P,S))).

undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.


pt(User):-

		analisis(User,Disease),
		interface3(User,',Hasil prediksi kami, kamu dinyatakan ',Disease,' Untuk memastikan hal tersebut, segera lakukan pengecekan pada pusat kesehatan terdekat.'),
        write(User),write(',Hasil Diagnosis Kami, Kamu '),write(Disease),write('.'),undo,end.




end :-


		nl,nl,nl,
		sleep(0.7),
		write('|================================================================|'),nl,
		sleep(0.4),
		write("|              TERIMA KASIH DAN SAMPAI JUMPA LAGI                |"),nl,
		sleep(0.4),
		write('|================================================================|'),nl.

interface(X,Y,Z) :-
	atom_concat(X,Y, FAtom),
	atom_concat(FAtom,Z,FinalAtom),
	jpl_new('javax.swing.JFrame', ['Halaman Konsultasi'], F),
	jpl_new('javax.swing.JLabel',['Sistem Diagnosis Gejala Demam Berdarah'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
        jpl_call(F, setLocation, [100,100], _),
	jpl_call(F, setSize, [800,600], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,FinalAtom], N),
	jpl_call(F, dispose, [], _),
	write(N),nl,
	( (N == yes ; N == y)
      ->
       assert(yes(Z)) ;
       assert(no(Z)), fail).

interface2 :-
	jpl_new('javax.swing.JFrame', ['Halaman Utama'], F),
	jpl_new('javax.swing.JLabel',['Sistem Diagnosis Gejala Demam Berdarah'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [100,100], _),
	jpl_call(F, setSize, [800,600], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,'Selamat Datang di Sistem Diagnosis Demam Berdarah!!.
       Siapakah Nama Anda??'], N),
	jpl_call(F, dispose, [], _),

	(	N == @(null)
		->	write('you cancelled'),interface3('Kamu Membatalkan program
                ini. ','Terima Kasih ','Telah Menggunakan ','me.'),end,fail
		;	write("Selamat Datang, Siapakah Nama Anda?? : "),write(N),nl,pt(N)
	).


interface3(P,W1,D,W2) :-
	atom_concat(P,W1, A),
	atom_concat(A,D,B),
	atom_concat(B,W2,W3),
	jpl_new('javax.swing.JFrame', ['Halaman Diagnosis'], F),
	jpl_new('javax.swing.JLabel',['-Sistem Diagnosis Gejala Demam Berdarah'-'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [100,100], _),
	jpl_call(F, setSize, [800,600], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,W3], N),
	jpl_call(F, dispose, [], _),

	(	N == @(void)
		->	write('')
		;	write("")
	).

help :- write("Type 'start.' to start application and press Enter key").


























