drop domain if exists NumeroPositivo cascade;
drop domain if exists DataValida cascade;
drop domain if exists CoordinataLat cascade;
drop domain if exists CoordinataLong cascade;
drop domain if exists ControlloAnno cascade;

drop table if exists Documento cascade;
drop table if exists Emergenza cascade;
drop table if exists Scrittura;
drop table if exists Etichetta;
drop table if exists Autore;
drop table if exists Commento;
drop table if exists Utente cascade;
drop table if exists Tag;
drop table if exists ZonaColpita cascade;
drop table if exists Danneggiamento;
drop table if exists Contenimento;
drop table if exists ParolaChiave;
drop table if exists EnteDiPubblicazione;

create domain NumeroPositivo as Integer
default 0
check (value>=0 and value is not null);

create domain DataValida as Date
check (value <= current_date);

create domain CoordinataLat as numeric(6,4)
check (value >= -90 and value <= 90);

create domain CoordinataLong as numeric(7,4)
check (value >= -180 and value <= 180);

create domain ControlloAnno as integer
check (value <= extract (year from current_date));


create table Emergenza(
	Tipo varchar(50),
	Nome varchar(100),
	DataInizio DataValida not null,
	DataFine DataValida,
	Catalogazione varchar(30),
	
	constraint emergenza_pkey primary key(tipo,nome)
);

create table EnteDiPubblicazione(
	Nome varchar(50),
	Ambito varchar(30),
	AnnoDiFondazione ControlloAnno not null,
	Tipologia varchar(30),
	
	primary key(Nome,Ambito)
);

create table Autore(
	NumeroCartaIdentita varchar(30) primary key,
	Nome varchar(60),
	Cognome varchar(60),
	Nazionalita varchar(50),
	NomeTitoloDiStudio varchar(50) not null,
	AmbitoTitoloDiSTudio varchar(30) not null,
	DataRilascioTitoloDiStudio DataValida not null
);

create table Utente(
	Username varchar(30) primary key,
	Nome varchar(60),
	Cognome varchar(60),
	Reputazione integer default 0 not null,
	Email varchar(50) not null unique
);

create table ParolaChiave(
	Parola varchar(30) primary key
);

create table Documento(
	LinkSito varchar(1000) primary key,
	CounterMiPiace NumeroPositivo,
	CounterNonMiPiace NumeroPositivo,
	DataPubblicazione DataValida not null,
	Lingua varchar(50) not null,
	Descrizione varchar(500),
	Topic varchar(10) not null,
	Argomento varchar(30),
	Titolo varchar(50) not null,
	Tipologia varchar(30) default 'Miscellanea',
	CodiceNumerico integer,
	TipoEmergenza varchar(50) not null,
	NomeEmergenza varchar(100) not null,
	NomeEnte varchar(50),
	AmbitoEnte varchar(30),
	FormatoDiPubblicazione varchar(50),

	constraint documento_Tipo_Nome_Emergenza_fkey foreign key (TipoEmergenza,NomeEmergenza) references Emergenza(Tipo,Nome) 
		on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED,
	constraint documento_Nome_Ambito_Ente_fkey foreign key (NomeEnte,AmbitoEnte) references EnteDiPubblicazione(Nome,Ambito)
		on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED

);

create table Scrittura(
	LinkSitoDocumento varchar(1000),
	NumeroCartaIdentitaAutore varchar(30),
	
	constraint scrittura_pkey primary key(LinkSitoDocumento, NumeroCartaIdentitaAutore),
	constraint scrittura_LinkSitoDocumento_fkey foreign key (LinkSitoDocumento) references Documento(LinkSito)
		on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED,
	constraint scrittura_NumeroCartaIdentitaAutore_fkey foreign key (NumeroCartaIdentitaAutore) references Autore(NumeroCartaIdentita)
		on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED
);

create table Commento(
	ID serial primary key,
	Contenuto varchar(500) not null,
	CounterMiPiace NumeroPositivo,
	CounterNonMiPiace NumeroPositivo,
	LinkSitoDocumento varchar(1000) not null,
	UsernameUtente varchar(30) not null,

	constraint commento_LinkSitoDocumento_fkey foreign key (LinkSitoDocumento) references Documento(LinkSito)
		on update cascade on delete restrict,
	constraint commento_UsernameUtente_fkey foreign key(UsernameUtente) references Utente(Username)
		on update cascade on delete restrict
);

create table Tag(
	Nome varchar(10) primary key,
	UsernameUtente varchar(30) not null,

	constraint tag_UsernameUtente_fkey foreign key (UsernameUtente) references Utente(Username)
        on update cascade on delete restrict
);

create table Etichetta(
	Codice serial primary key,
	UsernameUtente varchar(30) not null,
	LinkSitoDocumento varchar(1000) not null,
	NomeTag varchar(10) not null,
	
	unique(UsernameUtente,LinkSitoDocumento,NomeTag),
    constraint etichetta_UsernameUtente_fkey foreign key (UsernameUtente) references Utente(Username)
        on update cascade on delete restrict
	    DEFERRABLE INITIALLY DEFERRED,
    constraint etichetta_LinkSitoDocumento_fkey foreign key (LinkSitoDocumento) references Documento(LinkSito)
        on update cascade on delete restrict
	    DEFERRABLE INITIALLY DEFERRED,
    constraint etichetta_NomeTag_fkey foreign key (NomeTag) references Tag(Nome)
        on update cascade on delete restrict
	    DEFERRABLE INITIALLY DEFERRED
);

create table ZonaColpita(
	Latitudine CoordinataLat,
	Longitudine CoordinataLong,
	Nome varchar(30) not null,
	
	primary key (Latitudine, Longitudine)
);

create table Danneggiamento(
	LatitudineZonaColpita CoordinataLat,
	LongitudineZonaColpita CoordinataLong,
	NomeEmergenza varchar(100),
	TipoEmergenza varchar(50),
	NumeroVittime NumeroPositivo,
	
	primary key(LatitudineZonaColpita,LongitudineZonaColpita,NomeEmergenza,TipoEmergenza),
    constraint danneggiamento_Tipo_Nome_Emergenza_fkey foreign key (TipoEmergenza,NomeEmergenza) references Emergenza(Tipo,Nome)
        on update cascade on delete restrict
        DEFERRABLE INITIALLY DEFERRED,
	
    constraint danneggiamento_Latitudine_LongitudineZonaColpita_fkey foreign key (LatitudineZonaColpita,LongitudineZonaColpita) references ZonaColpita(Latitudine,Longitudine)
        on update cascade on delete restrict
        DEFERRABLE INITIALLY DEFERRED
	
);

create table Contenimento(
	LinkSitoDocumento varchar(1000),
	ParolaChiave varchar(30),
	
	primary key(LinkSitoDocumento,ParolaChiave),
    constraint contenimento_LinkSitoDocumento_fkey foreign key (LinkSitoDocumento) references Documento(LinkSito)
        on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED,
    constraint contenimento_ParolaChiave_fkey foreign key (ParolaChiave) references ParolaChiave(Parola)
        on update cascade on delete restrict
		DEFERRABLE INITIALLY DEFERRED
);