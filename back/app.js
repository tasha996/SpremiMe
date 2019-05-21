const express = require('express');
const bodyParser = require('body-parser');
const logger = require('morgan'); 
const neo4j = require('neo4j-driver').v1;
const history = require('connect-history-api-fallback');
const crypto = require('crypto');

const neoPort = 11010; 
const driver = neo4j.driver('bolt://localhost:' + neoPort, neo4j.auth.basic('neo4j', 'tasha996'), {disableLosslessIntegers: true});
const session = driver.session();

const app = express();
const port = 3000;

// support parsing of application/json type post data
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// history mode
app.use(history());

// Add CORS
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

    // intercepts OPTIONS method
    if ('OPTIONS' === req.method) {
        res.sendStatus(200);
    } else {
        next();
    }
});

// Nezasticene rute //

// SIGN UP
app.post('/korisnik', function(req, res){
    let ime = (req.body.ime == null) ? "" : req.body.ime.trim();
    let prezime = (req.body.prezime == null) ? "" : req.body.prezime.trim();
    let mail = (req.body.mail == null) ? "" : req.body.mail.trim();
    let pass = (req.body.pass == null) ? "" : req.body.pass.trim();
    let token = crypto.randomBytes(20).toString('hex');

    if (ime == "" || prezime == "" || mail == "" || pass == "") {
        res.status(400).send('Form not valid');
        return;
    }
    //kad je mail koji vec postoji vrati  400, jer je mail unique 
    session
        .run ("CREATE (n:Korisnik { ime:{imePar}, prezime:{prezimePar}, mail:{mailPar}, pass:{passPar}, token:{tokenPar}, logged:0 }) RETURN n", 
            {imePar:ime, prezimePar:prezime, mailPar:mail, passPar:pass, tokenPar:token})
        .then (function(result){
            res.status(201).send(mail);
            session.close();
        })
        .catch(function(err){
            console.log(err);
            res.status(400).send('Ne moze se napraviti novi korisnik.');
        });
});

// LOGIN
app.post('/auth', function(req, res){
    let mail = (req.body.mail == null) ? "" : req.body.mail.trim();
    let pass = (req.body.pass == null) ? "" : req.body.pass.trim();

    console.log(mail);
    console.log(pass);

    if (mail == "" || pass == "") {
        res.status(400).send('Form not valid');
        return;
    }

    session
        .run ('MATCH (k:Korisnik {mail : {mailPar}, pass : {passPar} }) RETURN k.token, ID(k) ', 
                    {mailPar:mail, passPar:pass})
        .then (function(result){
            if(result.records[0]) {
                let id = result.records[0]._fields[1];
                let token = result.records[0]._fields[0];
                res.status(201).send({'id': id, 'token': token}); //bas token nadji
                return;
            }
            res.status(400).send('Wrong email or password');
            session.close();
        })
        .catch(function(err){
            console.log(err);
            res.status(400).send('Wrong email or password');
        });
});

// Dodaje TOKEN ako postoji
app.use((req, res, next) => {
    var auth = req.headers.authorization;
    var token = "";
    if (auth != null) {
        token = auth.split(' ')[1];
        req.body['token'] = token;
    }
    console.log('Token Protect: ' + token);
    next();
});

// LOG OUT
app.get('/logout', (req, res) => {
    console.log('logout');
    var oldtoken = req.body['token'];
    if (oldtoken == null) {
        res.status(200).send('How even?');
    } else {
        console.log('remove');
        let token = crypto.randomBytes(20).toString('hex');
        // change token of user
        session
        .run ('MATCH (k:Korisnik {token: {old}}) \
            SET k.token = {tok} \
            RETURN ID(k)', {old : oldtoken, tok : token})
        .then (function(result) {
            res.status(200).send('Logged out');
        })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
    }
});

// Zasticene rute //

var userID = -1;

// Block invalid token middleware
app.use((req, res, next) => {
    var token = req.body['token'];
    if (token == null) {
        res.status(401).send('No token provided');
        return;
    }
    session
        .run ('MATCH (k:Korisnik {token: {tok}}) RETURN ID(k)', {tok: token})
        .then (function(result){
            userID = result.records[0]._fields[0];
            next();
        })
        .catch(function(err){
            console.log(err);
            res.status(401).send('Invalid token');
        });
});

// Provera Tokena
app.post('/validate', (req, res) => {
    res.status(200).send({id : userID});
});


app.get('/korisnici', function(req, res){
    session
        .run ('MATCH(n:Korisnik) RETURN n')
            .then (function(result){
                 var niz = [];
                 result.records.forEach(function(record){
                   // niz.push(record._fields[0].properties) //korisnici samo
                   niz.push(record._fields[0])  //korisnici i id
                 });
                 res.send(niz);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//korisnik i ID njegovih recepata 
app.get('/korisnik/:id', function(req, res){
    let id = req.params.id;
    let rezultat;
    let korisnik;
    let recepti = [];
    session
        //'MATCH (k:Korisnik)-[:KREIRAO]->(r:Recept) WHERE ID(k) = '+  id + ' RETURN k, r'
        .run ('MATCH (k:Korisnik) WHERE ID(k) = '+  id + ' RETURN k')
        .then (function(result){
            korisnik = result.records[0]._fields[0];
            return session.run('MATCH (k:Korisnik)-[:KREIRAO]->(r:Recept) WHERE ID(k) = '+  id + ' RETURN r');
        })
        .then(function(result){
            for (let i = 0; i < result.records.length; i++) {
                recepti[i] = result.records[i]._fields[0].identity;
            }

            rezultat = {korisnik, recepti};
                // res.send(result.records[0]._fields[0].properties); //samo korsinik
                // res.send(result.records[0]._fields[1]);//recept
                //res.send((result.records[0]._fields[1].identity).toString());  //id recepta
            res.send(rezultat);
        })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

app.get('/sastojci', function(req, res){
    session
        .run ('MATCH(n:Sastojak) RETURN n')
            .then (function(result){
                 var niz = [];
                 result.records.forEach(function(record){
                    niz.push(record._fields[0])
                 });
                 res.send(niz);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//i sastojci
app.get('/recepti', function(req, res){
    let sastojci = [];
    session
        .run ('MATCH(n:Recept) RETURN n')
            .then (function(result){
                 var niz = [];
                 result.records.forEach(function(record){
                    niz.push(record._fields[0])
                 });
                 res.send(niz);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

app.get('/sastojak/:id', function(req, res){
    let id = req.params.id;
    console.log(id);
    session
        .run ('MATCH(n:Sastojak) WHERE ID(n) = ' + id + ' RETURN n')
            .then (function(result){
                 res.send(result.records[0]._fields[0].properties);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//get recept i njegovi sastojci
app.get('/recept/:id', function(req, res){
    let id = req.params.id;
    let rezultat;
    let recept;
    let korisnik;
    let datumKreiranja;
    let sastojci = [];
    let veze = [];
    let idKor;
    let vrsta;
    
    session.run ('MATCH (r)<-[v:KREIRAO]-(a:Korisnik) WHERE ID(r) = '+  id + ' RETURN r, v, a')
        .then (function(result){
            idKor = result.records[0]._fields[2].identity;
            vrsta = result.records[0]._fields[0].labels[1];
            recept = result.records[0]._fields[0].properties;
            datumKreiranja = result.records[0]._fields[1].properties; 
            korisnik = result.records[0]._fields[2].properties;
            return session.run ('MATCH (r)<-[k:KORISTI_SE]-(s:Sastojak) WHERE ID(r) = '+  id + ' RETURN r, s, k');
        })
        .then (function(result) {
                // console.log(result);
                for (let i = 0; i < result.records.length; i++) {
                    sastojci[i] = result.records[i]._fields[1];
                }

                for (let i = 0; i < result.records.length; i++) {
                    veze[i] = result.records[i]._fields[2].properties;
                }

            rezultat = {recept , sastojci, veze, korisnik, datumKreiranja, idKor, vrsta};
            res.send(rezultat);
        })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

app.delete('/recept/:id', function(req, res){
    let idrPar = req.params.id;
    console.log(idrPar);
    session
        .run ('MATCH (r:Recept) WHERE ID(r) = '+ idrPar +' DETACH DELETE r')
        .then (function(result){
            res.status(200).send('deleted');
        })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//ne moze da se menja naziv sastojka
app.put('/sastojak/:id', function(req, res){
    let id = req.params.id;
    let nvr = req.body.nvr;
    session
        .run ('MATCH (s:Sastojak) WHERE ID(s)='+ id +'\
        SET s.nutritivnaVr = {nvrPar}\
        RETURN s',{nvrPar : nvr})
            .then (function(result){
                res.status(200).send('updated');
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//azuriranje recepta 
app.put('/recept/:id', function(req, res){
    let id = req.params.id;
    let naziv = req.body.naziv;
    let uputstvo = req.body.uputstvo;
    let vremePripreme = req.body.vremePripreme;
    let opis = req.body.opis;
    let sastojci = req.body.sastojci;

    let niz='';
    for (let i = 0; i < uputstvo.length; i++) {
        niz += "'" + uputstvo[i] + "'";
        if (i != uputstvo.length-1) 
            niz +=  ", "
    }
    let s;
    let s3 = '';
    let s4 = '';
    
    for (let i = 0; i < sastojci.length; i++) {
        const sas = sastojci[i];
        s3 += "MATCH (s" + i + ":Sastojak) WHERE ID(s" + i + ") = " +  sas.id + "\n"; 
        s4 += "CREATE (s" + i + ")-[:KORISTI_SE {kolicina: '" + sas.kol + "', jedinica: '" + sas.jed + "', opis:'" + sas.opis + "'}]->(r) \n"
    }
    s5 = "MATCH (r:Recept) WHERE ID(r) = "+ id +"\n" ;
    s = s3 + s5 + s4;
    
    session
        .run ("MATCH (r:Recept)<-[k:KORISTI_SE]-(s:Sastojak) WHERE ID(r) = "+ id + " DELETE k;")
        .then(()=>session.run("MATCH (r:Recept) WHERE ID(r)="+ id + " SET r.naziv = '"+ naziv +"', r.uputstvo = [" + niz + "], r.vremePripreme = "+ vremePripreme +", r.opis = '"+ opis +"';\n"))
        .then(()=>session.run(s))
        .then (function(result){
             res.status(200).send('updated');
        })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        })
});

//podstring
app.get('/searchString', function(req, res){
    let sub = req.query.sub;
    
    session
        .run ("MATCH (s:Sastojak) WHERE toLower(s.naziv) contains '"+ sub.toLowerCase() +"' RETURN s")
            .then (function(result){
                var niz = [];
                result.records.forEach(function(record){
                    let info = record._fields[0];
                    niz.push({
                        id: info.identity,
                        naziv: info.properties.naziv,
                        nv: info.properties.nutritivnaVr
                    });
                });
                res.status(201).send(niz);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

//jela na osnovu sastojaka
app.get('/search', function(req, res){
    let a = req.query.sastojci;
    let niz = [];
    if (a != null) {
        niz = a.map(function (x) { 
            return parseInt(x, 10); 
        });
    }
    session
        .run ('MATCH (s:Sastojak) WHERE ID(s) in {nizP} WITH collect (s.naziv) AS res \
        MATCH (r:Recept) \
        WHERE ALL(\
          niz IN res\
          WHERE (r)<-[:KORISTI_SE]-(:Sastojak {naziv: niz}))\
        RETURN r', {nizP:niz})
            .then (function(result){
                var niz = [];
                result.records.forEach(function(record){
                    niz.push(record._fields[0].identity);
                });
                res.status(200).send(niz);
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});

app.post('/sastojak', function(req, res){
    let naziv = req.body.naziv;
    let nutritivnaVr = req.body.nutritivnaVr;

    session
        .run ('CREATE (n:Sastojak { naziv:{nazivPar}, nutritivnaVr:{nutPar} }) RETURN n', {nazivPar:naziv, nutPar:nutritivnaVr})
            .then (function(result){
                res.status(201).send(naziv);
                session.close();
             })
        .catch(function(err){
            console.log(err);
            res.status(400).send('Sastojak vec postoji');
        });
});

//pravi recept i dodaje sastojke u recept i veza sa korisnikom
app.post('/recept', function(req, res){
    let naziv = req.body.naziv;
    let idKor = req.body.idKor;
    let vremePripreme = req.body.vremePripreme;
    let opis = req.body.opis;
    let uputstvo = req.body.uputstvo;
    let sastojci = req.body.sastojci;
    let s;
    let niz = "";
    let datum = new Date().toLocaleDateString();
    let vrsta = req.body.vrsta.replace(/\s+/g, '');;

    let s1='',s2='',s3='',s4='',s5='';
    for (let i = 0; i < sastojci.length; i++) {
        const sas = sastojci[i];
        s1 += "MATCH (s" + i + ":Sastojak) WHERE ID(s" + i + ") = " +  sas.id + "\n"; 
        s3 += "CREATE (s" + i + ")-[:KORISTI_SE {kolicina: '" + sas.kol + "' , jedinica: '" + sas.jed + "', opis:'" + sas.opis + "'}]->(r) \n"
    }

    for (let i = 0; i < uputstvo.length; i++) {
        niz += "'" + uputstvo[i] + "'";
        if (i != uputstvo.length-1) 
            niz +=  ", "
    }
    s2 = "CREATE (r:Recept:" + vrsta + " { naziv:'" + naziv + "', uputstvo:[" + niz + "], vremePripreme:" + vremePripreme + ", opis:'" + opis + "' }) \n"
    s4 = "MATCH (k:Korisnik) WHERE ID(k) = "+ idKor +"\n";
    s5 = "CREATE (k)-[:KREIRAO {datum: '"+ datum + "'}]->(r)\n";
    //CREATE (k)-[:KREIRAO {datum: '2015-07-21'}]->(r)

    s = s4 + s1 + s2 + s3 + s5;
    console.log(s);
    // res.send(200);
    session
        .run (s)
            .then (function(result){
                res.status(201).send("Recept kreiran");
                session.close();
             })
        .catch(function(err){
            console.log(err);
            res.status(400).send('Ne moze se kreirati novi recept.');
        });
});



app.post('/test', function(req, res){

    //console.log(req.body);
    session
        .run ("MATCH (s0:Sastojak) WHERE ID(s0) = 190 \
        MATCH (s1:Sastojak) WHERE ID(s1) = 191 \
        CREATE (r:Recept:Desert { naziv:'Ruska salata4', uputstvo:['1','2','3'], vremePripreme:30, opis:'Najlepsa' }) \
        CREATE (s0)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r) \
        CREATE (s1)-[:KORISTI_SE {kolicina:1, jedinica:'komad', opis:'razmuceno'}]->(r)")
            .then (function(result){
                res.status(200).send(result);
                session.close();
             })
        .catch(function(err){
            console.log(err);
            res.status(404).send('Not found');
        });
});




// Listen
app.listen(port, () => console.log(`Example app listening on port ${port}!`));