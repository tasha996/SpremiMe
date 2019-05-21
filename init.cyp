MATCH (n) DETACH DELETE n;

CREATE CONSTRAINT ON (s:Sastojak) ASSERT s.naziv IS UNIQUE;
CREATE CONSTRAINT ON (r:Recept) ASSERT r.naziv IS UNIQUE;
CREATE CONSTRAINT ON (k:Korisnik) ASSERT k.mail IS UNIQUE;

//Korisnici
CREATE (k1:Korisnik {mail: 'taki@mail.com', pass: '12345678', ime: 'Tamara', prezime: 'Vukadinovic', token: '1234'}), 
       (k2:Korisnik {mail: 'miki@mail.com', pass: '12345678', ime: 'Miodrag', prezime: 'Mikic', token: '1233'}),
       (k3:Korisnik {mail: 'joca@mail.com', pass: '12345678', ime: 'Jovan', prezime: 'Vukadinovic', token: '1255'}),
       (k4:Korisnik {mail: 'joka@mail.com', pass: '12345678', ime: 'Jovana', prezime: 'Markovic', token: '1277'}),
       (k5:Korisnik {mail: 'tasa@mail.com', pass: '12345678', ime: 'Tanja', prezime: 'Peric', token: '1288'})


//Sastojci
CREATE (s1:Sastojak {naziv:'Jaje', nutritivnaVr:5}), 
       (s2:Sastojak {naziv:'Brasno', nutritivnaVr:5}),
       (s3:Sastojak {naziv:'Mleko', nutritivnaVr:5}),
       (s4:Sastojak {naziv:'Jogurt', nutritivnaVr:5}),
       (s5:Sastojak {naziv:'So', nutritivnaVr:5}),
       (s6:Sastojak {naziv:'Secer', nutritivnaVr:15}),
       (s7:Sastojak {naziv:'Margarin', nutritivnaVr:120}),
       (s8:Sastojak {naziv:'Zejtin', nutritivnaVr:17}),
       (s9:Sastojak {naziv:'Maslac', nutritivnaVr:5}),
       (s10:Sastojak {naziv:'Kvasac', nutritivnaVr:5}),
       (s11:Sastojak {naziv:'Sirce', nutritivnaVr:5}),
       (s12:Sastojak {naziv:'Kakao', nutritivnaVr:5}),
       (s13:Sastojak {naziv:'Voda', nutritivnaVr:5}),
       (s14:Sastojak {naziv:'Krompir', nutritivnaVr:5}),
       (s15:Sastojak {naziv:'Paprika', nutritivnaVr:30}),
       (s16:Sastojak {naziv:'Crni luk', nutritivnaVr:5}),
       (s17:Sastojak {naziv:'Kupus', nutritivnaVr:5}),
       (s18:Sastojak {naziv:'Beli luka', nutritivnaVr:5}),
       (s19:Sastojak {naziv:'Svinjsko meso', nutritivnaVr:5}),
       (s20:Sastojak {naziv:'Krmenadla', nutritivnaVr:5}),
       (s21:Sastojak {naziv:'Piskote', nutritivnaVr:5}),
       (s22:Sastojak {naziv:'Maskarpone sir', nutritivnaVr:200}),
       (s23:Sastojak {naziv:'Slatka pavlaka', nutritivnaVr:5}),
       (s24:Sastojak {naziv:'Secer u prahu', nutritivnaVr:5}),
       (s25:Sastojak {naziv:'Maslinovo ulje', nutritivnaVr:5}),
       (s26:Sastojak {naziv:'Junece meso', nutritivnaVr:100}),
       (s27:Sastojak {naziv:'Biber', nutritivnaVr:5}),
       (s28:Sastojak {naziv:'Kackavalj', nutritivnaVr:150}),
       (s29:Sastojak {naziv:'Paradajz sos', nutritivnaVr:5}),
       (s30:Sastojak {naziv:'Sunka', nutritivnaVr:250}),
       (s31:Sastojak {naziv:'Cajna kobasica', nutritivnaVr:500}),   
       (s32:Sastojak {naziv:'Pilece meso', nutritivnaVr:400}),
       (s33:Sastojak {naziv:'Sargarepa', nutritivnaVr:50}),
       (s34:Sastojak {naziv:'Rezanci', nutritivnaVr:70}),
       (s35:Sastojak {naziv:'Pasulj', nutritivnaVr:150}),
       (s36:Sastojak {naziv:'Paradajz', nutritivnaVr:5}),
       (s37:Sastojak {naziv:'Sir', nutritivnaVr:100}),
       (s38:Sastojak {naziv:'Limun', nutritivnaVr:5}),
       (s39:Sastojak {naziv:'Orasi', nutritivnaVr:5}),
       (s40:Sastojak {naziv:'Slag', nutritivnaVr:5})
       

//Recepti
CREATE (p1:Recept:Predjelo {naziv:'Supa', uputstvo:['U jedan lonac sipati 2 litre hladne vode, staviti kašikicu soli, 
        par zrna bibera, 1 lovorov list, staviti 1/2 pileta bez belog mesa sa sitninom (džigericu malo kasnije da ne bi pocrnela supa), 
        2 šargarepe, 2 zeleni, to iseći pa ubaciti, 1 glavicu crnog luka, 1 mali krompir, 1 parče celera. Kuvati na tihoj vatri.',
        'Kada provri, skinuti penu cetkom za supu, dodati džigericu, 2 kašikice vegete, smanjiti i ostaviti da polako vri. 
        Kada je meso kuvano izvaditi na jedan tanjir, posoliti i ono se može jesti posebno sa paradajz sosom ili se prepržiti pa tako jesti. 
        Na drugi tanjir izvaditi sitninu iz supe (glavu, noge, zelen, šargarepu, džigericu, luk, krompir,...) i procediti supu.',
         'Kada je proceđena vratiti na vatru da provri, kada provri sipati 2-3 šake rezanaca i kada se rezanci skuvaju supa je gotova.'], 
         vremePripreme:100, opis:'Najbolja domaca supa!'}),
       
       (p2:Recept:Predjelo {naziv:'Zacinjena meksicka corba', uputstvo:['Očistiti pasulj, oprati ga, kuvati 15 minuta i baciti prvu vodu, 
       zatim naliti toplu vodu i kuvati pasulj na tihoj vatri, uz povremeno dolivanje tople vode ili bujona. Neka uvek bude tek malo iznad pasulja. 
       Potpuno skuvan pasulj držati u vodi u kojoj se kuvao do upotrebe.', 'Na tihoj vatri ugrejati maslinovo ulje, pa dodati sitno seckan crni luk. Mešati. 
       Posle par minuta dodati kim, da se i on proprži s lukom. Zatim dodati sitno seckan beli luk i iseckanu ljutu papriku. 
       Sipati sok od paradajza, dodati oguljen, isečen, paradajz i kašičicu šećera, pa sve dinstati na tihoj vatri nekoliko minuta.  
        Dodati skuvan pasulj s nešto vode u kojoj se kuvao. ', 'Zagrejati vodu ili domaći bujon, pa sipati preko povrća u šerpi. 
        Promešati i kuvati na tihoj vatri oko 40 minuta, dok se čorba ne bude zgusnula, a tečnost redukovala.
         Povremeno promešati uz dolivanje tople vode, ako je previše tečnosti isparilo. Posoliti, pobiberiti sveže mlevenim biberom i dodati iseckan peršun. ', 
        'Servirati toplu čorbu, a povrh čorbe izdrobiti feta sir. '], vremePripreme:120, opis:'Ovo je čorba za hladne dane, koja krepi telo i duh i ubrzava cirkulaciju :)
         Ljutina može da se dozira. Obrok-čorbe su zdrave, ukusne, zasitne, a nimalo komplikovane za pravljenje.'}),

         (p3:Recept:Predjelo {naziv:'Domaca supa', uputstvo:['U jedan lonac sipati 2 litre hladne vode, staviti kašikicu soli, 
        par zrna bibera, 1 lovorov list, staviti 1/2 pileta bez belog mesa sa sitninom (džigericu malo kasnije da ne bi pocrnela supa), 
        2 šargarepe, 2 zeleni, to iseći pa ubaciti, 1 glavicu crnog luka, 1 mali krompir, 1 parče celera. Kuvati na tihoj vatri.',
        'Kada provri, skinuti penu cetkom za supu, dodati džigericu, 2 kašikice vegete, smanjiti i ostaviti da polako vri. 
        Kada je meso kuvano izvaditi na jedan tanjir, posoliti i ono se može jesti posebno sa paradajz sosom ili se prepržiti pa tako jesti. 
        Na drugi tanjir izvaditi sitninu iz supe (glavu, noge, zelen, šargarepu, džigericu, luk, krompir,...) i procediti supu.',
         'Kada je proceđena vratiti na vatru da provri, kada provri sipati 2-3 šake rezanaca i kada se rezanci skuvaju supa je gotova.'], 
         vremePripreme:120, opis:'Najbolja domaca supa!'}),
       
       (p4:Recept:Predjelo {naziv:'Corba', uputstvo:['Očistiti pasulj, oprati ga, kuvati 15 minuta i baciti prvu vodu, 
       zatim naliti toplu vodu i kuvati pasulj na tihoj vatri, uz povremeno dolivanje tople vode ili bujona. Neka uvek bude tek malo iznad pasulja. 
       Potpuno skuvan pasulj držati u vodi u kojoj se kuvao do upotrebe.', 'Na tihoj vatri ugrejati maslinovo ulje, pa dodati sitno seckan crni luk. Mešati. 
       Posle par minuta dodati kim, da se i on proprži s lukom. Zatim dodati sitno seckan beli luk i iseckanu ljutu papriku. 
       Sipati sok od paradajza, dodati oguljen, isečen, paradajz i kašičicu šećera, pa sve dinstati na tihoj vatri nekoliko minuta.  
        Dodati skuvan pasulj s nešto vode u kojoj se kuvao. ', 'Zagrejati vodu ili domaći bujon, pa sipati preko povrća u šerpi. 
        Promešati i kuvati na tihoj vatri oko 40 minuta, dok se čorba ne bude zgusnula, a tečnost redukovala.
         Povremeno promešati uz dolivanje tople vode, ako je previše tečnosti isparilo. Posoliti, pobiberiti sveže mlevenim biberom i dodati iseckan peršun. ', 
        'Servirati toplu čorbu, a povrh čorbe izdrobiti feta sir. '], vremePripreme:70, opis:'Ovo je čorba za hladne dane, koja krepi telo i duh i ubrzava cirkulaciju :)
         Ljutina može da se dozira. Obrok-čorbe su zdrave, ukusne, zasitne, a nimalo komplikovane za pravljenje.'}),



       (j1:Recept:GlavnoJelo {naziv:'Podvarak', uputstvo:['U većoj šerpi, propržiti crni i beli luk. Dodati meso i šargarepe i dobro propržiti. 
       Dodati sos od paradajza, začiniti i kuvati na laganoj vatri oko pola sata.', 
       'Za beli sos, na ulju i puteru propržiti brašno, na vrlo niskoj temperaturi. Polako dodavati mleko, stalno mešajući. 
       Dodati i začine, i kad se sve zgusne, dodati narendani sir. Ako hoćete manje sira, slobodno smanjite količinu. 
       Najvažnije je da znate da lazanje treba da budu sočne i nije bitno da imaju čvrsto držanje. ', 
       'U pleh za pečenje, prvo staviti red crvenog sosa. Preko toga prekriti listovima za lazanje. 
       Zatim red belog sosa pa testo i red crvenog sosa. Naseći sveži Mocarela sir na kolutiće i tako prekriti crveni sos. 
       Staviti preko svega još jedan red listova lazanje i premazati svim ostatkom belog sosa. 
       Odgore treba staviti malo soka od crvenog sosa, da beli sos nebi izgoreo. Kad je ispečeno – oko 1 sat na 180 stepeni, odgore staviti Parmezan i peći još 10 minuta.', 'Prijatno!'],
        vremePripreme:90, opis:'Ovaj recept pravim već 35 godina i još se nije desilo da nije bio obožavan!'}),
       
       (j2:Recept:GlavnoJelo {naziv:'Lazanje', uputstvo:['U većoj šerpi, propržiti crni i beli luk. Dodati meso i šargarepe i dobro propržiti. 
       Dodati sos od paradajza, začiniti i kuvati na laganoj vatri oko pola sata.', 
       'Za beli sos, na ulju i puteru propržiti brašno, na vrlo niskoj temperaturi. Polako dodavati mleko, stalno mešajući. 
       Dodati i začine, i kad se sve zgusne, dodati narendani sir. Ako hoćete manje sira, slobodno smanjite količinu. 
       Najvažnije je da znate da lazanje treba da budu sočne i nije bitno da imaju čvrsto držanje. ', 
       'U pleh za pečenje, prvo staviti red crvenog sosa. Preko toga prekriti listovima za lazanje. 
       Zatim red belog sosa pa testo i red crvenog sosa. Naseći sveži Mocarela sir na kolutiće i tako prekriti crveni sos. 
       Staviti preko svega još jedan red listova lazanje i premazati svim ostatkom belog sosa. 
       Odgore treba staviti malo soka od crvenog sosa, da beli sos nebi izgoreo. Kad je ispečeno – oko 1 sat na 180 stepeni, odgore staviti Parmezan i peći još 10 minuta.', 'Prijatno!'],
        vremePripreme:90, opis:'Ovaj recept pravim već 35 godina i još se nije desilo da nije bio obožavan!'}),

       (j3:Recept:GlavnoJelo {naziv:'Pica', uputstvo:['U toploj vodi vodi staviti kašičicu šećera i izdrobiti kvasac. 
       Sačekati da naraste. U brašno staviti so, ostatak šećera, ulje, i vodu sa kvascem. 
       Umesiti testo (ako je potrebno dodati još brašna). Podeliti testo na 2 dela i ostaviti da naraste (odprilike 15-ak minuta).',
        'Oba pleha dobro premazati uljem (da se ne bi testo zalepilo) i razvući testo rukama. Po testu sipatu kečap i ravnomerno razmazati.',
         'Zatim staviti: šunku (na polukrugove), čajnu kobasicu, slaninicu, pečurke (na listiće), masline (količina po želji). Na svaku 1/8 testa rabiti jaje (po želji). 
         Posuti sa origanom i obilno nastrugati kačkavalj.', 'Staviti da se peče u prethodno zagrejanu rernu na 190 stepeni.'], vremePripreme:40, opis:'Pica po receptu pravih majstora.'}),

      (j4:Recept:GlavnoJelo {naziv:'Neobicna musaka', uputstvo:['Ocistite povrce i nasecite na kriske.', 'Na ulju proprzite glavicu luka, dodajte mleveno meso i jos malo przite. 
      Dodajte so, vegetu, mleveni biber i crvenu papriku, mlevenu.', 
      'U posudi u kojoj cete peci musaku prvo stavite uspravno red krompira pa fil od mljevenog mesa, jedan red mrkve pa fil, red paradajza pa fil.', 
      'Redjajte redom dok sve ne potrosite i ispunite posudu do kraja.', 'Zalijte vrucom vodom malo ispod nivoa povrca.  
      Posolite po malo redove povrca i kasikom stavite po malo ulja na svaki red: krompira, mrkve i paradajza.', 
      'Stavite u pecnici da se pece.', 'Pred sam kraj kad se musaka zapece zalijte je umucenim jajima kojim ste dodali mleko. Vratite nazad u pecnici jos malo.'],
        vremePripreme:90, opis:'Neobicna musaka, jer se razlikuje od klasicne musake.  Uspravna jer se povrce koje koristimo stavlja uspravno. 
        Ja sam bila zadivljena njenim izgledom kad sam zavrsila redjanjem povrca do kraja'}),


      (j5:Recept:GlavnoJelo {naziv:'Spagete bolonjeze', uputstvo:['U toploj vodi vodi staviti kašičicu šećera i izdrobiti kvasac. 
       Sačekati da naraste. U brašno staviti so, ostatak šećera, ulje, i vodu sa kvascem. 
       Umesiti testo (ako je potrebno dodati još brašna). Podeliti testo na 2 dela i ostaviti da naraste (odprilike 15-ak minuta).',
        'Oba pleha dobro premazati uljem (da se ne bi testo zalepilo) i razvući testo rukama. Po testu sipatu kečap i ravnomerno razmazati.',
         'Zatim staviti: šunku (na polukrugove), čajnu kobasicu, slaninicu, pečurke (na listiće), masline (količina po želji). Na svaku 1/8 testa rabiti jaje (po želji). 
         Posuti sa origanom i obilno nastrugati kačkavalj.', 'Staviti da se peče u prethodno zagrejanu rernu na 190 stepeni.'], vremePripreme:40, opis:'Pica po receptu pravih majstora.'}),

      (j6:Recept:GlavnoJelo {naziv:'Musaka od krompira', uputstvo:['Ocistite povrce i nasecite na kriske.', 'Na ulju proprzite glavicu luka, dodajte mleveno meso i jos malo przite. 
      Dodajte so, vegetu, mleveni biber i crvenu papriku, mlevenu.', 
      'U posudi u kojoj cete peci musaku prvo stavite uspravno red krompira pa fil od mljevenog mesa, jedan red mrkve pa fil, red paradajza pa fil.', 
      'Redjajte redom dok sve ne potrosite i ispunite posudu do kraja.', 'Zalijte vrucom vodom malo ispod nivoa povrca.  
      Posolite po malo redove povrca i kasikom stavite po malo ulja na svaki red: krompira, mrkve i paradajza.', 
      'Stavite u pecnici da se pece.', 'Pred sam kraj kad se musaka zapece zalijte je umucenim jajima kojim ste dodali mleko. Vratite nazad u pecnici jos malo.'],
        vremePripreme:90, opis:'Neobicna musaka, jer se razlikuje od klasicne musake.  Uspravna jer se povrce koje koristimo stavlja uspravno. 
        Ja sam bila zadivljena njenim izgledom kad sam zavrsila redjanjem povrca do kraja'}),



       (d1:Recept:Desert {naziv:'Tiramisu', uputstvo:['Za Tiramisu koristim malu vatrostalnu posudu, koja je dimenzija 16 cm x 26 cm, 
       ali je konusnog oblika, pa se ka dnu sužava. Recept je dat baš za tu veličinu posude.', 'Najpre treba napraviti preliv za namakanje piškota: 
       staviti vodu da provri, pa njome preliti nes kafu. Dobro izmešati, da se sve granule kafe rastope. Zatim dodati mleko i rum i ostaviti sa strane.', 
       'Krema: Razbiti jaja, pa belanca staviti u jednu posudu, a žumanca u drugu. Belanca ulupati mikserom u čvrst sneg, pa dodati 8 kašika šećera. Mutiti još malo, da se šećer rastopi, pa ostaviti sa strane. ',
        'Žumancima dodati 8 kašika šećera, pa ih dobro izmutiti mikserom. Dodati sir i malo vanile, pa dobro promešati. U žumanca dodati sneg od belanaca, pa obe smese lepo i nežno promešati špatulom, da se dobije fina gusta krema.',
        'U posudu za Tiramisu staviti par kašika kreme, pa na nju slagati piškote, provlačeći ih prvo kroz preliv sa nes kafom. Složene piškote premazati kremom, pa na kremu složiti još jedan red piškota. Ostatak kreme staviti na piškote,
         zagladiti kremu da se lepo poravna, pa staviti u frižider.', 'Tiramisu je najbolji sutradan, kad odstoji u frižideru 24 sata, jer se tada lepo seče, i kocke su pravilne (što kod mene nije slučaj, jer smo ga načeli posle nekoliko sati). 
         Pred samo služenje, Tiramisu treba posuti kakaom ili čokoladom u prahu (najlepše je kada kakao stavite u cediljku za čaj, jer tada ravnomerno posipate ceo kolač).'], 
         vremePripreme:90, opis:'Dugo već pravim Tiramisu po ovom receptu... '}),

        (d2:Recept:Desert {naziv:'Puslica', uputstvo:['Umutiti dva puta po 5 belanaca, 280 g šećera i sok od pola limuna. Odvojeno ispeći dve kore.', 
        'Fil: 5 žumanaca kuvati na pari sa 4 kašike šećera, jednom kašikom brašna i 4 decilitra mleka. Kuvati dok se ne zgusne. Dodati 300 g samlevenih oraha.
        Posebno umutiti preostalih 5 žumanaca sa 250 g butera i 250 g šećera u prahu, pa pomešati sa prohlađenim kremom.', 
        'Umutiti šlag iz 4 kesice, pa nadevati tortu na sledeći način: prvu koru premazati kremom, preko krema staviti šlag; staviti drugu koru, premazati kremom i odozgo šlagom, pa šlagom ukrasiti tortu.'],
        vremePripreme:180, opis:'Najukusnija torta koju sam ikada probala.'}),

        (d3:Recept:Desert {naziv:'Cheesecake', uputstvo:['Za Tiramisu koristim malu vatrostalnu posudu, koja je dimenzija 16 cm x 26 cm, 
       ali je konusnog oblika, pa se ka dnu sužava. Recept je dat baš za tu veličinu posude.', 'Najpre treba napraviti preliv za namakanje piškota: 
       staviti vodu da provri, pa njome preliti nes kafu. Dobro izmešati, da se sve granule kafe rastope. Zatim dodati mleko i rum i ostaviti sa strane.', 
       'Krema: Razbiti jaja, pa belanca staviti u jednu posudu, a žumanca u drugu. Belanca ulupati mikserom u čvrst sneg, pa dodati 8 kašika šećera. Mutiti još malo, da se šećer rastopi, pa ostaviti sa strane. ',
        'Žumancima dodati 8 kašika šećera, pa ih dobro izmutiti mikserom. Dodati sir i malo vanile, pa dobro promešati. U žumanca dodati sneg od belanaca, pa obe smese lepo i nežno promešati špatulom, da se dobije fina gusta krema.',
        'U posudu za Tiramisu staviti par kašika kreme, pa na nju slagati piškote, provlačeći ih prvo kroz preliv sa nes kafom. Složene piškote premazati kremom, pa na kremu složiti još jedan red piškota. Ostatak kreme staviti na piškote,
         zagladiti kremu da se lepo poravna, pa staviti u frižider.', 'Tiramisu je najbolji sutradan, kad odstoji u frižideru 24 sata, jer se tada lepo seče, i kocke su pravilne (što kod mene nije slučaj, jer smo ga načeli posle nekoliko sati). 
         Pred samo služenje, Tiramisu treba posuti kakaom ili čokoladom u prahu (najlepše je kada kakao stavite u cediljku za čaj, jer tada ravnomerno posipate ceo kolač).'], 
         vremePripreme:110, opis:'Dugo već pravim Tiramisu po ovom receptu... '}),

        (d4:Recept:Desert {naziv:'Torta sa orasima', uputstvo:['Umutiti dva puta po 5 belanaca, 280 g šećera i sok od pola limuna. Odvojeno ispeći dve kore.', 
        'Fil: 5 žumanaca kuvati na pari sa 4 kašike šećera, jednom kašikom brašna i 4 decilitra mleka. Kuvati dok se ne zgusne. Dodati 300 g samlevenih oraha.
        Posebno umutiti preostalih 5 žumanaca sa 250 g butera i 250 g šećera u prahu, pa pomešati sa prohlađenim kremom.', 
        'Umutiti šlag iz 4 kesice, pa nadevati tortu na sledeći način: prvu koru premazati kremom, preko krema staviti šlag; staviti drugu koru, premazati kremom i odozgo šlagom, pa šlagom ukrasiti tortu.'],
        vremePripreme:90, opis:'Najukusnija torta koju sam ikada probala.'}),

        (d5:Recept:Desert {naziv:'Americka pita', uputstvo:['Za Tiramisu koristim malu vatrostalnu posudu, koja je dimenzija 16 cm x 26 cm, 
       ali je konusnog oblika, pa se ka dnu sužava. Recept je dat baš za tu veličinu posude.', 'Najpre treba napraviti preliv za namakanje piškota: 
       staviti vodu da provri, pa njome preliti nes kafu. Dobro izmešati, da se sve granule kafe rastope. Zatim dodati mleko i rum i ostaviti sa strane.', 
       'Krema: Razbiti jaja, pa belanca staviti u jednu posudu, a žumanca u drugu. Belanca ulupati mikserom u čvrst sneg, pa dodati 8 kašika šećera. Mutiti još malo, da se šećer rastopi, pa ostaviti sa strane. ',
        'Žumancima dodati 8 kašika šećera, pa ih dobro izmutiti mikserom. Dodati sir i malo vanile, pa dobro promešati. U žumanca dodati sneg od belanaca, pa obe smese lepo i nežno promešati špatulom, da se dobije fina gusta krema.',
        'U posudu za Tiramisu staviti par kašika kreme, pa na nju slagati piškote, provlačeći ih prvo kroz preliv sa nes kafom. Složene piškote premazati kremom, pa na kremu složiti još jedan red piškota. Ostatak kreme staviti na piškote,
         zagladiti kremu da se lepo poravna, pa staviti u frižider.', 'Tiramisu je najbolji sutradan, kad odstoji u frižideru 24 sata, jer se tada lepo seče, i kocke su pravilne (što kod mene nije slučaj, jer smo ga načeli posle nekoliko sati). 
         Pred samo služenje, Tiramisu treba posuti kakaom ili čokoladom u prahu (najlepše je kada kakao stavite u cediljku za čaj, jer tada ravnomerno posipate ceo kolač).'], 
         vremePripreme:100, opis:'Dugo već pravim Tiramisu po ovom receptu... '}),

        (d6:Recept:Desert {naziv:'Torta lenja zena', uputstvo:['Umutiti dva puta po 5 belanaca, 280 g šećera i sok od pola limuna. Odvojeno ispeći dve kore.', 
        'Fil: 5 žumanaca kuvati na pari sa 4 kašike šećera, jednom kašikom brašna i 4 decilitra mleka. Kuvati dok se ne zgusne. Dodati 300 g samlevenih oraha.
        Posebno umutiti preostalih 5 žumanaca sa 250 g butera i 250 g šećera u prahu, pa pomešati sa prohlađenim kremom.', 
        'Umutiti šlag iz 4 kesice, pa nadevati tortu na sledeći način: prvu koru premazati kremom, preko krema staviti šlag; staviti drugu koru, premazati kremom i odozgo šlagom, pa šlagom ukrasiti tortu.'],
        vremePripreme:45, opis:'Najukusnija torta koju sam ikada probala.'})
       


//Veze sastojak-recept
CREATE
  (s1)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(p2),
  (s14)-[:KORISTI_SE {kolicina:3, jedinica:'komada', opis:'na komadice'}]->(p2),
  (s15)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckana'}]->(p2),
  (s13)-[:KORISTI_SE {kolicina:6, jedinica:'dl', opis:'mlaka'}]->(p2),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckan'}]->(p2),
  (s35)-[:KORISTI_SE {kolicina:160, jedinica:'gr', opis:''}]->(p2),
  (s8)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(p2),
  (s29)-[:KORISTI_SE {kolicina:1, jedinica:'dl', opis:''}]->(p2),
  (s36)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:''}]->(p2),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p2),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p2),
  (s37)-[:KORISTI_SE {kolicina:80, jedinica:'gr', opis:''}]->(p2)

CREATE
  (s1)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(p4),
  (s14)-[:KORISTI_SE {kolicina:3, jedinica:'komada', opis:'na komadice'}]->(p4),
  (s15)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckana'}]->(p4),
  (s13)-[:KORISTI_SE {kolicina:6, jedinica:'dl', opis:'mlaka'}]->(p4),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckan'}]->(p4),
  (s35)-[:KORISTI_SE {kolicina:160, jedinica:'gr', opis:''}]->(p4),
  (s8)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(p4),
  (s29)-[:KORISTI_SE {kolicina:1, jedinica:'dl', opis:''}]->(p4),
  (s36)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:''}]->(p4),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p4),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p4),
  (s37)-[:KORISTI_SE {kolicina:80, jedinica:'gr', opis:''}]->(p4)

CREATE
  (s32)-[:KORISTI_SE {kolicina:'pola', jedinica:'', opis:'sitno iseckano'}]->(p1),
  (s33)-[:KORISTI_SE {kolicina:2, jedinica:'komada', opis:'sitno iseckane'}]->(p1),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckan'}]->(p1),
  (s14)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:'sitno iseckan'}]->(p1),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p1),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p1),
  (s34)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(p1)

CREATE
  (s32)-[:KORISTI_SE {kolicina:'pola', jedinica:'', opis:'sitno iseckano'}]->(p3),
  (s33)-[:KORISTI_SE {kolicina:2, jedinica:'komada', opis:'sitno iseckane'}]->(p3),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckan'}]->(p3),
  (s14)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:'sitno iseckan'}]->(p3),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p3),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(p3),
  (s34)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(p3)



CREATE
  (s8)-[:KORISTI_SE {kolicina:1, jedinica:'dl', opis:''}]->(j1),
  (s19)-[:KORISTI_SE {kolicina:3, jedinica:'komada', opis:'na komadice'}]->(j1),
  (s17)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckan'}]->(j1),
  (s13)-[:KORISTI_SE {kolicina:2, jedinica:'dl', opis:'mlaka'}]->(j1),
  (s20)-[:KORISTI_SE {kolicina:200, jedinica:'gr', opis:''}]->(j1),
  (s16)-[:KORISTI_SE {kolicina:0, jedinica:'po ukusu', opis:''}]->(j1),
  (s18)-[:KORISTI_SE {kolicina:1, jedinica:'cen', opis:''}]->(j1),
  (s11)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j1) 

CREATE
  (s25)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'malo'}]->(j2),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'sitno iseckani'}]->(j2),
  (s19)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:'mleveno'}]->(j2),
  (s26)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:'mleveno'}]->(j2),
  (s29)-[:KORISTI_SE {kolicina:0.5, jedinica:'kg', opis:''}]->(j2),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j2),
  (s8)-[:KORISTI_SE {kolicina:1, jedinica:'dl', opis:''}]->(j2),
  (s7)-[:KORISTI_SE {kolicina:3, jedinica:'kasike', opis:''}]->(j2),
  (s2)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(j2),
  (s3)-[:KORISTI_SE {kolicina:3, jedinica:'solje', opis:''}]->(j2),
  (s28)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:'svezeg'}]->(j2)  

CREATE
  (s2)-[:KORISTI_SE {kolicina:950, jedinica:'gr', opis:''}]->(j3),
  (s13)-[:KORISTI_SE {kolicina:5, jedinica:'dl', opis:''}]->(j3),
  (s8)-[:KORISTI_SE {kolicina:80, jedinica:'ml', opis:''}]->(j3),
  (s5)-[:KORISTI_SE {kolicina:2, jedinica:'kasicice', opis:''}]->(j3),
  (s6)-[:KORISTI_SE {kolicina:2, jedinica:'kasicice', opis:''}]->(j3),
  (s30)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:'seckana'}]->(j3),
  (s31)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:''}]->(j3),
  (s28)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:'rendanog'}]->(j3),
  (s10)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:''}]->(j3)

CREATE
  (s2)-[:KORISTI_SE {kolicina:950, jedinica:'gr', opis:''}]->(j5),
  (s13)-[:KORISTI_SE {kolicina:5, jedinica:'dl', opis:''}]->(j5),
  (s8)-[:KORISTI_SE {kolicina:80, jedinica:'ml', opis:''}]->(j5),
  (s5)-[:KORISTI_SE {kolicina:2, jedinica:'kasicice', opis:''}]->(j5),
  (s6)-[:KORISTI_SE {kolicina:2, jedinica:'kasicice', opis:''}]->(j5),
  (s30)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:'seckana'}]->(j5),
  (s31)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:''}]->(j5),
  (s28)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:'rendanog'}]->(j5),
  (s10)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:''}]->(j5)

CREATE
  (s19)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:''}]->(j4),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:''}]->(j4),
  (s8)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j4),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j4),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j4),
  (s14)-[:KORISTI_SE {kolicina:5, jedinica:'komada', opis:''}]->(j4),
  (s36)-[:KORISTI_SE {kolicina:4, jedinica:'komada', opis:''}]->(j4),
  (s33)-[:KORISTI_SE {kolicina:4, jedinica:'komada', opis:''}]->(j4),
  (s1)-[:KORISTI_SE {kolicina:3, jedinica:'', opis:''}]->(j4),
  (s3)-[:KORISTI_SE {kolicina:2, jedinica:'dl', opis:''}]->(j4)

CREATE
  (s19)-[:KORISTI_SE {kolicina:400, jedinica:'gr', opis:''}]->(j6),
  (s16)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:''}]->(j6),
  (s8)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j6),
  (s5)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j6),
  (s27)-[:KORISTI_SE {kolicina:'', jedinica:'', opis:'po ukusu'}]->(j6),
  (s14)-[:KORISTI_SE {kolicina:5, jedinica:'komada', opis:''}]->(j6),
  (s36)-[:KORISTI_SE {kolicina:4, jedinica:'komada', opis:''}]->(j6),
  (s33)-[:KORISTI_SE {kolicina:4, jedinica:'komada', opis:''}]->(j6),
  (s1)-[:KORISTI_SE {kolicina:3, jedinica:'', opis:''}]->(j6),
  (s3)-[:KORISTI_SE {kolicina:2, jedinica:'dl', opis:''}]->(j6)


CREATE
  (s21)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d1),
  (s22)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'razmucen'}]->(d1),
  (s23)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'cvrsto umucecna'}]->(d1),
  (s1)-[:KORISTI_SE {kolicina:6, jedinica:'komada', opis:'svezih'}]->(d1),
  (s12)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(d1),
  (s9)-[:KORISTI_SE {kolicina:200, jedinica:'gr', opis:''}]->(d1),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d1)

CREATE
  (s21)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d3),
  (s22)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'razmucen'}]->(d3),
  (s23)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'cvrsto umucecna'}]->(d3),
  (s1)-[:KORISTI_SE {kolicina:6, jedinica:'komada', opis:'svezih'}]->(d3),
  (s12)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(d3),
  (s9)-[:KORISTI_SE {kolicina:200, jedinica:'gr', opis:''}]->(d3),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d3)

CREATE
  (s21)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d5),
  (s22)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'razmucen'}]->(d5),
  (s23)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:'cvrsto umucecna'}]->(d5),
  (s1)-[:KORISTI_SE {kolicina:6, jedinica:'komada', opis:'svezih'}]->(d5),
  (s12)-[:KORISTI_SE {kolicina:2, jedinica:'kasike', opis:''}]->(d5),
  (s9)-[:KORISTI_SE {kolicina:200, jedinica:'gr', opis:''}]->(d5),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d5)


CREATE
  (s1)-[:KORISTI_SE {kolicina:10, jedinica:'komada', opis:''}]->(d2),
  (s6)-[:KORISTI_SE {kolicina:600, jedinica:'gr', opis:''}]->(d2),
  (s38)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:''}]->(d2),
  (s2)-[:KORISTI_SE {kolicina:1, jedinica:'kasika', opis:''}]->(d2),
  (s3)-[:KORISTI_SE {kolicina:4, jedinica:'dl', opis:''}]->(d2),
  (s39)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:'mlevenih'}]->(d2),
  (s7)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d2),
  (s40)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d2),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d2)

CREATE
  (s1)-[:KORISTI_SE {kolicina:10, jedinica:'komada', opis:''}]->(d4),
  (s6)-[:KORISTI_SE {kolicina:600, jedinica:'gr', opis:''}]->(d4),
  (s38)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:''}]->(d4),
  (s2)-[:KORISTI_SE {kolicina:1, jedinica:'kasika', opis:''}]->(d4),
  (s3)-[:KORISTI_SE {kolicina:4, jedinica:'dl', opis:''}]->(d4),
  (s39)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:'mlevenih'}]->(d4),
  (s7)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d4),
  (s40)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d4),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d4)

CREATE
  (s1)-[:KORISTI_SE {kolicina:10, jedinica:'komada', opis:''}]->(d6),
  (s6)-[:KORISTI_SE {kolicina:600, jedinica:'gr', opis:''}]->(d6),
  (s38)-[:KORISTI_SE {kolicina:1, jedinica:'', opis:''}]->(d6),
  (s2)-[:KORISTI_SE {kolicina:1, jedinica:'kasika', opis:''}]->(d6),
  (s3)-[:KORISTI_SE {kolicina:4, jedinica:'dl', opis:''}]->(d6),
  (s39)-[:KORISTI_SE {kolicina:300, jedinica:'gr', opis:'mlevenih'}]->(d6),
  (s7)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d6),
  (s40)-[:KORISTI_SE {kolicina:500, jedinica:'gr', opis:''}]->(d6),
  (s24)-[:KORISTI_SE {kolicina:250, jedinica:'gr', opis:''}]->(d6),
  (s4)-[:KORISTI_SE {kolicina:1, jedinica:'dl', opis:''}]->(d6)


//Veze korisnik-recept
CREATE
  (k1)-[:KREIRAO {datum: '2019-1-15'}]->(p1),
  (k1)-[:KREIRAO {datum: '2019-1-15'}]->(p2),
  (k2)-[:KREIRAO {datum: '2019-1-15'}]->(j1),
  (k1)-[:KREIRAO {datum: '2019-1-10'}]->(j2),
  (k4)-[:KREIRAO {datum: '2018-11-17'}]->(j3),
  (k1)-[:KREIRAO {datum: '2019-1-15'}]->(j5),
  (k1)-[:KREIRAO {datum: '2019-1-15'}]->(j6),
  (k4)-[:KREIRAO {datum: '2018-11-20'}]->(j4),
  (k3)-[:KREIRAO {datum: '2019-1-15'}]->(d1),
  (k5)-[:KREIRAO {datum: '2017-1-15'}]->(d2),
  (k5)-[:KREIRAO {datum: '2017-1-15'}]->(p3),
  (k5)-[:KREIRAO {datum: '2017-1-15'}]->(p4),
  (k1)-[:KREIRAO {datum: '2019-1-15'}]->(d3),
  (k2)-[:KREIRAO {datum: '2019-1-15'}]->(d4),
  (k4)-[:KREIRAO {datum: '2018-11-20'}]->(d5),
  (k4)-[:KREIRAO {datum: '2018-11-20'}]->(d6)