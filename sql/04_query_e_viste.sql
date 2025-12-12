
--QUERY
--Query con operatore di aggregazione e join: Controllo Tag e Parola chiave

select D.Titolo as Documento, count(T.Nome) as NumeroTag, count(C.ParolaChiave) as numeroparolechiave
from Etichetta E
	join Documento D on (D.LinkSito=E.LinkSitoDocumento)
	join Tag T on (T.Nome = E.NomeTag)
	join Contenimento C on(E.LinkSitoDocumento = C.LinkSitoDocumento) 
group by T.Nome,D.LinkSito
having count(C.ParolaChiave)>0 
order by count(C.ParolaChiave);

--Query nidificata complessa: Controllo Documenti

SELECT *
FROM Scrittura
WHERE LinkSitodocumento IN (
	SELECT LinkSito
	FROM Documento D
	WHERE NomeEmergenza IN (
		SELECT DAN.NomeEmergenza
		FROM danneggiamento DAN
		where (D.formatodipubblicazione='PDF' or D.formatodipubblicazione='ebook') 
			and D.nomeente <> 'Wiley-Blackwell'
			 ))
and NumeroCartaIdentitaAutore in(
	select NumeroCartaIdentita 
	from Autore
	where Nazionalita='Italiana');

--Query insiemistica: Controllo Emergenze

select E1.Nome, E1.Tipo, count(D1.LinkSito) as NumeroDocumenti
from Emergenza E1 join Documento D1 on E1.Nome = D1.NomeEmergenza and E1.Tipo = D1.TipoEmergenza
where E1.catalogazione = 'Emergenza Corrente' and E1.tipo = 'Incidente' 
group by E1.Nome, E1.Tipo

intersect

select E2.Nome, E2.Tipo, count(D2.LinkSito) as NumeroDocumenti
from Emergenza E2 join Documento D2 on E2.Nome = D2.NomeEmergenza and E2.Tipo = D2.TipoEmergenza
where (exists (select * from Danneggiamento D3
			  where E2.Nome = D3.NomeEmergenza and E2.Tipo = D3.TipoEmergenza and D3.NumeroVittime > 10))
group by E2.Nome, E2.Tipo

union

select E3.Nome,E3.Tipo, count(D3.LinkSito) as NumeroDocumenti
from Emergenza E3 join Documento D3 on E3.Nome = D3.NomeEmergenza and E3.Tipo = D3.TipoEmergenza
where E3.catalogazione ='Emergenza Passata' and E3.tipo='Terrorismo'
group by E3.Nome, E3.Tipo;

--EVENTUALI ALTRE QUERY
--Analisi approfondita dei documenti

SELECT LinkSito, datapubblicazione, descrizione,tipologia,NomeEnte,Formatodipubblicazione
FROM Documento
WHERE LinkSito IN (
    SELECT LinkSitoDocumento
    FROM Scrittura
    WHERE NumeroCartaIdentitaAutore IN (
        SELECT NumeroCartaIdentita
        FROM Autore
        WHERE NomeTitoloDiSTudio = 'Dottorato'
    )
	
	intersect
	
    SELECT LinkSitoDocumento
    FROM Etichetta
    WHERE UsernameUtente IN (
        SELECT Username
        FROM Utente
        WHERE Reputazione > 5
    )
)
AND TipoEmergenza IN (
    SELECT Tipo
    FROM Emergenza
    WHERE Nome IN (
        SELECT NomeEmergenza
        FROM Danneggiamento
        WHERE NumeroVittime > 10
    )
);

--Resoconto Autori

SELECT Autore.NumeroCartaIdentita, Autore.Nome, Autore.Cognome, COUNT(Documento.LinkSito) AS NumeroDiDocumenti
FROM Autore
	JOIN Scrittura ON Autore.NumeroCartaIdentita = Scrittura.NumeroCartaIdentitaAutore
	JOIN Documento ON Scrittura.LinkSitoDocumento = Documento.LinkSito
GROUP BY Autore.NumeroCartaIdentita, Autore.Nome, Autore.Cognome;


--VISTE
--Vista Analisi attività utente

DROP VIEW IF EXISTS analisi_attivita_utente;
create view analisi_attivita_utente as
select U.Username, U.Reputazione, cast(avg(C.CounterMiPiace) as decimal(6,2)) as MediaMiPiace, 
		T.Nome as Tag
from Utente U join Commento C on U.Username = C.UsernameUtente
			join Tag T on T.UsernameUtente = U.Username
where U.reputazione > 0
group by U.username, U.reputazione, T.Nome
order by U.reputazione desc;

--Query con Vista: Miglior utente

select Username, mediaMiPiace, count(Tag) as NumeroTag
from analisi_attivita_utente
where mediaMiPIace = (
	select max(mediaMiPiace) from analisi_attivita_utente
)
group by username, mediaMiPiace;

--Vista Panoramica Emergenze

DROP VIEW IF EXISTS panoramica_emergenze;
create view panoramica_emergenze as
select E.nome as Emergenza, E.DataInizio as Data, Z.nome as ZonaColpita, D.NumeroVittime, DOC.titolo as Documento, DOC.CounterMiPiace as NumeroMiPiace, count(A.NumeroCartaIdentita) as NumeroAutori
from Emergenza E join danneggiamento D on E.nome = D.nomeEmergenza and E.tipo = D.tipoEmergenza
				join zonaColpita Z on D.latitudineZonaColpita = Z.Latitudine and D.longitudineZonaColpita = Z.Longitudine
				join Documento DOC on DOC.NomeEmergenza = E.Nome and DOC.TipoEmergenza = E.Tipo
				join Scrittura S on S.LinkSitoDocumento = DOC.LinkSito 
				join Autore A on S.NumeroCartaIdentitaAutore = A.NumeroCartaIdentita
where DOC.CounterMiPiace = (select max(D2.CounterMiPiace) from Documento D2
							where E.nome = D2.nomeEmergenza and E.tipo = D2.tipoEmergenza)
group by E.nome, E.DataInizio, Z.nome, D.NumeroVittime , DOC.titolo, DOC.CounterMiPiace;

--Query con Vista:  Conteggio vittime emergenze

select emergenza, data, sum(numerovittime) as totaleVittime
from panoramica_emergenze
where extract(year from data) >= 2019
group by emergenza, data
order by sum(numerovittime) desc;

--Query con Vista: Miglior documento

select distinct emergenza, documento
from panoramica_emergenze 
where NumeroMiPiace = (select max(NumeroMiPiace) from panoramica_emergenze
							where extract(year from data) = 2020);
