match(p:Predjelo) return p.uputstvo[0]

match(p:Predjelo) return ID(p)

MATCH (s) WHERE ID(s) = 65110 RETURN s

MATCH (k:Korisnik) WHERE ID(k) = 49
MATCH (s0:Sastojak) WHERE ID(s0) = 82
MATCH (s1:Sastojak) WHERE ID(s1) = 60
CREATE (r:Recept:Desert { naziv:'Ruska salata4', uputstvo:['1','2','3'], vremePripreme:30, opis:'Najlepsa' })
CREATE (s0)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r)
CREATE (s1)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r)
CREATE (k)-[:KREIRAO {datum: '2015-07-21'}]->(r)

MATCH (s:Sastojak)-[:KORISTI_SE]->(r:Recept)
 
 //ne radi
MATCH (r:Recept) <-[:KORISTI_SE]-(s:Sastojak) AND ID(s) = 100
RETURN r


MATCH (s:Sastojak) WHERE ID(s) in [12,13] WITH collect (s.naziv) AS res
MATCH (r:Recept)
WHERE ALL(
  niz IN res
  WHERE (r)<-[:KORISTI_SE]-(:Sastojak {naziv: niz}))
RETURN r

MATCH (r:Recept) WHERE ID(r) = 27 
DETACH DELETE r

//ako pisemo sve atribute
MERGE (s:Sastojak {naziv: 'Jaje'})
SET s = {naziv: 'Jaje', nutritivnaVr:10}
RETURN s

//sa id-jem radi ali mora svi atributi da se proslede
MATCH (s:Sastojak ) WHERE ID(s)=52
SET s = {naziv: 'Jaje', nutritivnaVr:10}
RETURN s

//samo neke atribute menjamo
MERGE (s:Sastojak {naziv: 'Jaje'})
SET s.nutritivnaVr = 34
RETURN s

//sa id-jem radi
MATCH (s:Sastojak) WHERE ID(s)=52
SET s.nutritivnaVr = 15
RETURN s

//recept i sastojci
MATCH (r)<-[:KORISTI_SE]-(s:Sastojak) WHERE ID(r) = 20 
RETURN r,s

//update recepta
MATCH (r:Recept)<-[k:KORISTI_SE]-(s:Sastojak) WHERE ID(r) = 21
DELETE k;

MATCH (r:Recept) WHERE ID(r)=21
SET r.naziv = 'Supa', r.uputstvo = ['1', '2'], r.vremePripreme = 20, r.opis = '';

MATCH (s0:Sastojak) WHERE ID(s0) = 60
MATCH (s1:Sastojak) WHERE ID(s1) = 63
MATCH (r:Recept) WHERE ID(r) = 14
CREATE (s0)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r)
CREATE (s1)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r)

//substring recept
MATCH (r:Recept) WHERE toLower(r.naziv) contains 'cor' return r

//substring sastojak
MATCH (s:Sastojak) WHERE toLower(s.naziv) contains 'cor' return s.naziv, ID(s)

//korisnik vrati token
MATCH (k:Korisnik {mail:'pera@mail.com', pass: '12345678'}) RETURN k.token 