

INSERT INTO Utente (Username, Nome, Cognome, Email)
VALUES
	('docMaurizio','Maurizio','Marotta','m.marotta@gmail.com'),
	('thatsrux02','Vincenzo','Maldini','v.maldini02@libero.it'),
	('luciaB','Lucia','Bianchi','luciaB@icloud.com'),
	('juan','Giovanni','Battista','g_battista@gmail.com'),
	('leone','Leone','Crispino','leone.crisp@gmail.com'),
	('lollegro','Lorenzo','Iantosca','l.iantosca@icloud.com'),
	('ngiolett','Angelo','Infante','a.infante02@gmail.com'),
	('kyaranas','Annachiara','Senatore','a.senatore@gmail.com'),
	('tony','Antonio','Napoli','a.napoli@libero.it'),
	('pepi','Giuseppe','Stella','g.stella04@gmail.com');

START TRANSACTION;
INSERT INTO Scrittura (LinkSitoDocumento, NumeroCartaIdentitaAutore)
VALUES
    ('http://documento1.com', 'AB12332CV'),
	('http://documento1.com', 'XY98765ZT'),
    ('http://documento2.com', 'XY98765ZT'),
    ('http://documento3.com', 'PQ45678LM'),
	('http://documento3.com', 'GH54321IJ'),
	('http://documento3.com', 'EF87654KJ'),
    ('http://documento4.com', 'CD23456FG'),
    ('http://documento5.com', 'EF87654KJ'),
	('http://documento6.com', 'LM34567OP'),
    ('http://documento7.com', 'JK56789MN'),
    ('http://documento8.com', 'UV43210RS'),
    ('http://documento9.com', 'WX09876VW'),
    ('http://documento10.com', 'GH54321IJ'),
	('http://documento11.com', 'GH54321IJ'),
    ('http://documento11.com', 'LM34567OP'),
	('http://documento3.com', 'VD27219JK'),
	('http://documento8.com', 'AZ78252YX'),
	('http://documento1.com', 'MN84337LZ'),
	('http://documento11.com', 'FA77432CC'),
	('http://documento9.com', 'IO36912PD'),
	('http://documento12.com', 'JK56789MN'),
	('http://documento13.com', 'IO36912PD'),
	('http://documento13.com', 'LM34567OP');

INSERT INTO Documento (LinkSito, CounterMiPiace, CounterNonMiPiace, DataPubblicazione, Lingua, Descrizione, Topic, Argomento, Titolo, Tipologia, CodiceNumerico, TipoEmergenza, NomeEmergenza, NomeEnte, AmbitoEnte, FormatoDiPubblicazione)
VALUES
    ('http://documento1.com', 50, 5, '2024-05-01', 'Inglese', 'Analisi incendio disastroso', 'Ambiente', 'Effetti post esplosione', 'Building on fire for 5 hours straight', 'Articolo Giornalistico', NULL, 'Incidente', 'Esplosione centrale di Suviana', 'Wiley-Blackwell', 'Editoria', 'PDF'),
    ('http://documento2.com', 30, 2, '2011-11-04', 'Inglese', 'Studio meteo nord Italia', 'Ambiente', 'Condizioni meteo avverse','Water everywhere!','Pubblicazione Scientifica', 54321, 'Alluvione', 'Nubifragio Genova 2011', 'Oxford University Press', 'Editoria', 'eBook'),
    ('http://documento3.com', 20, 1, '2017-08-21', 'Italiano', 'Analisi cause terremoto', 'Ambiente', 'Aiuti umanitari','Isola distrutta', 'Pubblicazione Scientifica', 98765, 'Terremoto', 'Sisma Ischia 2017', 'Università di Bologna', 'Istruzione', 'Online'),
    ('http://documento4.com', 40, 3, '2012-01-20', 'Italiano', 'Analisi tecnica Concordia', 'Ambiente', NULL,'Che impatto ha avuto?', 'Miscellanea', NULL, 'Incidente', 'Naufragio Costa Concordia', 'IEEE', 'Ingegneria', 'Cartaceo'),
    ('http://documento5.com', 25, 4, '2024-05-08', 'Italiano', 'Rapporto tempesta', 'Ambiente', NULL,'Come comportarsi se la tempesta dovesse ripetersi', 'Decreto', 13579, 'Incidente', 'Valanga Austria 2024', 'Ministero della Salute', 'Pubblica Amministrazione', 'PDF'),
	('http://documento6.com', 15, 3, '2024-05-06', 'Italiano', 'Analisi degli effetti dell inquinamento', 'Attualità', 'Danni alla natura','Paura in mare', 'Miscellanea', NULL, 'Inquinamento', 'Isola di plastica Arcipelago Toscano', 'Università di Torino', 'Istruzione', 'Online'),
    ('http://documento7.com', 28, 6, '2020-01-07', 'Francese', 'Tragedia memorabile', 'Attualità', 'Attentato terroristico','Pourquoi?', 'Articolo giornalistico', NULL, 'Terrorismo', 'Massacro Charlie Hebdo', 'Corriere della Sera', 'Stampa', 'PDF'),
    ('http://documento8.com', 10, 2, '2021-01-21', 'Spagnolo', 'Rapporto sull andamento della pandemia di COVID-19', 'Salute', 'Vaccinazioni e morte','Resoconto Covid-19', 'Decreto', 98765, 'Pandemia', 'Covid-19', 'Diaro de España', 'Stampa', 'Online'),
    ('http://documento9.com', 35, 8, '2014-05-30', 'Belga', 'Resoconto attacco Isis', 'Attualità', 'Attacchi dell Isis','Isis colpisce ancora', 'Articolo Giornalistico', NULL, 'Terrorismo', 'Attacco Bruxelles 2014', 'Springer', 'Editoria', 'Cartaceo'),
    ('http://documento10.com', 20, 4, '2024-05-17', 'Italiano', 'Studio sui danni causati dal terremoto a Crete', 'Ambiente', NULL,'Analisi sui terremoti', 'Rivista', NULL, 'Terremoto', 'Sisma mb 4.6 Crete', 'Oxford University Press', 'Varie', 'eBook'),
	('http://documento11.com',10,30,'2012-06-10','Italiano','Analisi colpe', 'Ambiente', NULL,'Chi è il responsabile?','Articolo Giornalistico', NULL, 'Incidente', 'Naufragio Costa Concordia', 'Corriere della Sera', 'Stampa', 'Cartaceo'),
	('http://documento12.com', 1, 10, '2020-01-01', 'Francese', 'Opinioni sul Covid-19', 'Salute', 'Cause del Covid-19','COVID-19, una piaga mondiale', 'Blog', NULL, 'Pandemia', 'Covid-19', NULL, NULL, NULL),
    ('http://documento13.com', 30, 5, '2021-06-03', 'Italiana', 'Analisi effetti della pandemia', 'Salute', 'Effetti Covid-19','Un incubo senza fine', 'Articolo Giornalistico', NULL, 'Pandemia', 'Covid-19', 'Corriere della Sera', 'Stampa', 'PDF');
	
INSERT INTO Autore (NumeroCartaIdentita, Nome, Cognome, Nazionalita, NomeTitoloDiStudio, AmbitoTitoloDiSTudio, DataRilascioTitoloDiStudio)
VALUES
    ('AB12332CV', 'Mario', 'Rossi', 'Italiana', 'Laurea', 'Politica estera', '2020-01-15'),
    ('XY98765ZT', 'John', 'Stone', 'Britannica', 'Dottorato', 'Medicina farmaceutica', '2019-05-20'),
    ('PQ45678LM', 'Giovanni', 'Verdi', 'Italiana', 'Laurea', 'Legge', '2021-11-10'),
    ('CD23456FG', 'Carla', 'Neri', 'Italiana', 'Dottorato', 'Scienza', '2018-08-05'),
    ('EF87654KJ', 'Luigi', 'Rosa', 'Italiana', 'Dottorato', 'Letteratura italiana', '2022-03-30'),
	('LM34567OP', 'Elena', 'Ferrari', 'Italiana', 'Laurea', 'Economia e management', '2022-09-25'),
    ('JK56789MN', 'Antoine', 'Mbappe', 'Francese', 'Dottorato', 'Ingegneria informatica', '2023-11-18'),
    ('UV43210RS', 'Alvaro', 'Morata', 'Spagnola', 'Dottorato', 'Psicologia', '2021-03-12'),
    ('WX09876VW', 'Manuel', 'Rudiger', 'Tedesca', 'Dottorato', 'Filosofia moderna', '2020-07-30'),
    ('GH54321IJ', 'Giacomina', 'Ricci', 'Italiana', 'Laurea', 'Arte moderna','2019-02-15'),
	('VD27219JK', 'Mauricio', 'Kiwi', 'Spagnola', 'Diploma', 'Scientifico','2021-06-20'),
    ('AZ78252YX', 'João', 'Felix', 'Portoghese', 'Laurea', 'Letteratura spagnola','2015-01-03'),
    ('MN84337LZ', 'Sigmund', 'Eriksen', 'Norvegese', 'Laurea', 'Oncologia','2009-11-15'),
    ('FA77432CC', 'Frederika', 'Müller', 'Austriaco', 'Dottorato', 'Microbiologia','2017-07-01'),
    ('IO36912PD', 'Francesco', 'Marzano', 'Italiana', 'Dottorato', 'Fisioterapia','2022-10-15');

	
INSERT INTO EnteDiPubblicazione (Nome, Ambito, AnnoDiFondazione, Tipologia)
VALUES
    ('Springer', 'Editoria', 1842, 'Casa Editrice'),
    ('Università di Bologna', 'Istruzione', 1088, 'Istituzione'),
	('Corriere della Sera', 'Stampa', 1876, 'Casa Editrice'),
    ('Ministero della Salute', 'Pubblica Amministrazione', 1958, 'Istituzione'),
    ('Università di Torino', 'Istruzione', 1404, 'Istituzione'),
    ('Oxford University Press', 'Editoria', 1586, 'Casa Editrice'),
	('Diaro de España', 'Stampa', 2022, 'Casa Editrice'),
    ('Wiley-Blackwell', 'Editoria', 1922, 'Istituzione'),
    ('Oxford University Press', 'Varie', 1586, 'Istituzione'),
    ('IEEE', 'Ingegneria', 1963, 'Istituzione');
	
INSERT INTO Danneggiamento (LatitudineZonaColpita, LongitudineZonaColpita, NomeEmergenza, TipoEmergenza, NumeroVittime)
VALUES
    (40.7328, 13.9512, 'Sisma Ischia 2017', 'Terremoto', 10), 
    (44.1362, 11.0363, 'Esplosione centrale di Suviana', 'Incidente', 23),
    (40.3434, -3.5101, 'Massacro Charlie Hebdo', 'Terrorismo', 30), 
    (41.3932, 2.1711, 'Covid-19', 'Pandemia', 20), 
    (52.5088, 13.3489, 'Attacco Bruxelles 2014', 'Terrorismo', 2),
	(39.8733, 11.2315, 'Isola di plastica Arcipelago Toscano', 'Inquinamento', 0),
    (42.4656, 13.5673, 'Valanga Austria 2024', 'Incidente', 12), 
    (37.6548, 12.9891, 'Naufragio Costa Concordia', 'Incidente', 50),
    (41.7863, 8.1023, 'Nubifragio Genova 2011', 'Alluvione', 4),
    (44.3288, 10.8799, 'Sisma mb 4.6 Crete', 'Terremoto', 3),
	(44.3212, 10.9882, 'Covid-19', 'Pandemia', 27),
    (44.5222, 10.8549, 'Sisma mb 4.6 Crete', 'Terremoto', 8),
	(40.9191, 14.7822, 'Covid-19','Pandemia',100);

INSERT INTO Emergenza (Tipo, Nome, DataInizio, DataFine, Catalogazione)
VALUES

	('Terremoto', 'Sisma Ischia 2017', '2017-08-21', '2017-08-21', 'Emergenza Passata'),
	('Incidente', 'Esplosione centrale di Suviana', '2024-04-09', NULL, 'Emergenza Corrente'),
	('Pandemia','Covid-19','2019-02-21','2021-03-22','Emergenza Passata'),
    ('Alluvione', 'Nubifragio Genova 2011', '2011-11-04', '2011-11-04', 'Emergenza Passata'),
    ('Incidente', 'Naufragio Costa Concordia', '2012-01-13', '2012-01-13', 'Emergenza Passata'),
    ('Terrorismo', 'Massacro Charlie Hebdo', '2015-01-07', '2015-01-07', 'Emergenza Passata'),
	('Terrorismo', 'Attacco Bruxelles 2014', '2014-05-24', '2014-05-24', 'Emergenza Passata'),
	('Incidente', 'Valanga Austria 2024', '2024-05-07', NULL, 'Emergenza Corrente'),
	('Inquinamento', 'Isola di plastica Arcipelago Toscano', '2020-05-05', NULL, 'Emergenza Corrente'),
    ('Terremoto', 'Sisma mb 4.6 Crete', '2024-05-17', NULL, 'Emergenza Corrente');

INSERT INTO ZonaColpita (Latitudine, Longitudine, Nome)
VALUES
    (40.7328, 13.9512, 'Isola'),
    (44.1362, 11.0363, 'Centrale idroelettrica'),
    (40.3434, -3.5101, 'Ufficio'), 
    (41.3932, 2.1711, 'Città'), 
    (52.5088, 13.3489, 'Autostrada'),
	(39.8733, 11.2315, 'Oceano'),
    (42.4656, 13.5673, 'Montagna'), 
    (37.6548, 12.9891, 'Mare'),
    (41.7863, 8.1023, 'Città'),
    (44.3288, 10.8799, 'Campagna'),
	(44.3212, 10.9882, 'Città'),
    (44.5222, 10.8549, 'Metropoli'),
    (40.9191, 14.7822, 'Città');
    
COMMIT;

start transaction;
INSERT INTO Contenimento (LinkSitoDocumento, ParolaChiave)
VALUES
    ('http://documento7.com', 'Politica'),
	('http://documento9.com', 'Politica'),
	('http://documento8.com', 'Salute'),
	('http://documento9.com', 'Cultura'),
	('http://documento1.com', 'Economia'),
	('http://documento6.com', 'Economia'),
	('http://documento8.com', 'Economia'),
	('http://documento1.com', 'Scienza'),
	('http://documento4.com', 'Scienza'),
    ('http://documento8.com', 'Scienza'),
	('http://documento3.com', 'Attentato'),
	('http://documento9.com', 'Attentato'),
	('http://documento2.com', 'Maltempo'),
	('http://documento3.com', 'Terremoto'),
	('http://documento10.com', 'Terremoto'),
	('http://documento1.com', 'Morte'),
	('http://documento3.com', 'Morte'),
	('http://documento4.com', 'Morte'),
	('http://documento7.com', 'Morte'),
	('http://documento8.com', 'Morte'),
	('http://documento9.com', 'Morte'),
	('http://documento10.com', 'Morte'),
	('http://documento11.com', 'Morte'),
	('http://documento4.com', 'Sopravvissuti'),
	('http://documento9.com', 'Sopravvissuti'),
	('http://documento11.com', 'Sopravvissuti'),
	('http://documento1.com', 'Evacuazione'),
	('http://documento4.com', 'Evacuazione'),
	('http://documento11.com', 'Evacuazione'),
	('http://documento2.com', 'Pericolo'),
	('http://documento6.com', 'Pericolo'),
	('http://documento1.com', 'Soccorso'),
	('http://documento2.com', 'Soccorso'),
	('http://documento3.com', 'Soccorso'),
	('http://documento10.com', 'Soccorso');

INSERT INTO ParolaChiave (Parola)
VALUES
    ('Politica'),
    ('Salute'),
    ('Cultura'),
    ('Economia'),
    ('Scienza'),
    ('Attentato'),
    ('Maltempo'),
    ('Terremoto'),
    ('Morte'),
    ('Sopravvissuti'),
    ('Evacuazione'),
    ('Pericolo'),
    ('Soccorso');
COMMIT;

INSERT INTO Commento (Contenuto, CounterMiPiace, CounterNonMiPiace, LinkSitoDocumento, UsernameUtente)
VALUES
    ('Molto interessante!', 2, 10, 'http://documento1.com', 'luciaB'),
    ('Concordo con quanto detto.', 1, 5, 'http://documento2.com', 'thatsrux02'),
    ('Questa ricerca è fondamentale.', 0, 8, 'http://documento3.com', 'docMaurizio'),
    ('Non sono d accordo con le conclusioni.', 9, 3, 'http://documento4.com', 'juan'),
    ('Documentazione completa e ben fatta.', 4, 6, 'http://documento5.com', 'ngiolett'),
	('Articolo molto dettagliato, ottimo lavoro!', 0, 12, 'http://documento6.com', 'thatsrux02'),
    ('Condivido le conclusioni dell analisi.', 10, 3, 'http://documento7.com', 'kyaranas'),
    ('Informazioni preziose, grazie!', 12, 3, 'http://documento8.com', 'pepi'),
    ('Aspetto nuovi sviluppi sull indagine.', 6, 2, 'http://documento9.com', 'tony'),
    ('Studio interessante, vorrei approfondire.', 9, 3, 'http://documento10.com', 'lollegro'),
	('Speriamo che la situazione migliori.', 0, 5, 'http://documento1.com', 'lollegro'),
	('Non condivido le conclusioni.', 5, 2, 'http://documento2.com', 'ngiolett'),
	('Ricerca molto accurata.', 0, 7, 'http://documento3.com', 'leone'),
	('Non sono d accordo con le conclusioni.', 9, 3, 'http://documento4.com', 'leone'),
	('Documentazione completa e ben fatta.', 1, 6, 'http://documento5.com', 'leone'),
	('Informazioni preziose, grazie!', 10, 3, 'http://documento11.com', 'pepi'),
    ('Aspetto nuovi sviluppi sull indagine.', 6, 0, 'http://documento11.com', 'lollegro');

start transaction;
INSERT INTO Etichetta (UsernameUtente, LinkSitoDocumento, NomeTag)
VALUES
    ('ngiolett', 'http://documento1.com', 'Politica'),
    ('kyaranas', 'http://documento1.com', 'Ambiente'),
    ('juan', 'http://documento8.com', 'Salute'),
    ('juan', 'http://documento4.com', 'Tecnologia'),
    ('pepi', 'http://documento4.com', 'Cultura'),
    ('ngiolett', 'http://documento6.com', 'Scienza'),
    ('kyaranas', 'http://documento2.com', 'Disastro'),
    ('pepi', 'http://documento7.com', 'Terrorismo'),
	('lollegro', 'http://documento5.com', 'Maltempo'),
    ('ngiolett', 'http://documento9.com', 'Incidente'),
	('pepi', 'http://documento8.com', 'Pandemia'),
	('tony', 'http://documento2.com', 'Alluvione'),
	('tony', 'http://documento1.com', 'Incendio'),
	('lollegro', 'http://documento10.com', 'Terremoto'),
	('ngiolett', 'http://documento11.com', 'Disastro'),
	('lollegro', 'http://documento11.com', 'Ambiente');

INSERT INTO Tag (Nome, UsernameUtente)
VALUES
    ('Politica', 'lollegro'),
    ('Ambiente', 'pepi'),
    ('Salute', 'lollegro'),
    ('Tecnologia', 'pepi'),
    ('Cultura', 'pepi'),
    ('Scienza', 'tony'),
    ('Disastro', 'tony'),
    ('Terrorismo', 'lollegro'),
	('Maltempo', 'lollegro'),
	('Incidente', 'lollegro'),
	('Pandemia', 'lollegro'),
	('Alluvione', 'pepi'),
	('Incendio', 'tony'),
	('Terremoto', 'lollegro');
commit;