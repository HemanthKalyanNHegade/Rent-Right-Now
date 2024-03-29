--Owner Table
CREATE TABLE IF NOT EXISTS Owner(
    Owner_ID int(6) auto_increment,
    primary key(Owner_ID),
    F_Name varchar(10) not null,
    L_Name varchar(10) not null,
    Username varchar(10) not null unique,
    Password varchar(10) not null,
    Owner_Addr varchar(50) unique,
    DOB date
);

alter table Owner auto_increment=100000;
insert INTO Owner(F_Name,L_Name,username,password,Owner_Addr,DOB) VALUES("Vrushank","G","vrush41","12345","2nd cross,millerpet,bellary",'2002-08-12');
insert INTO Owner(F_Name,L_Name,username,password,Owner_Addr,DOB) VALUES("Hemanth","N","hemanth28","23456","4th cross,gauribidanur,chikkaballapur",'2002-01-28');
insert INTO Owner(F_Name,L_Name,username,password,Owner_Addr,DOB) VALUES("Dhanush","M D","mdebro","34567","2nd cross,puttur,mangaluru",'2002-06-01');
insert INTO Owner(F_Name,L_Name,username,password,Owner_Addr,DOB) VALUES("Srinivas","Y","vasu03","45678","3rd cross,rr nagar,bengaluru",'2002-03-27');
insert INTO Owner(F_Name,L_Name,username,password,Owner_Addr,DOB) VALUES("Om","Prasad","om123","56789","2nd cross,jaynagar,bengaluru",'2002-05-10');


--Owner_Ph.No
CREATE TABLE IF NOT EXISTS Owner_Ph(
    Owner_ID int(6),
    constraint fk_owner_id foreign key(Owner_ID) REFERENCES Owner(Owner_ID),
    Ph_No char(10) not null
);
alter table Owner_Ph add constraint check_ph1 check(char_length(Ph_No)=10);

insert INTO Owner_Ph(Owner_ID,Ph_No) VALUES(100000,(9876929479));
insert INTO Owner_Ph(Owner_ID,Ph_No) VALUES(100001,(6968456239));
insert INTO Owner_Ph(Owner_ID,Ph_No) VALUES(100002,(9087565642));
insert INTO Owner_Ph(Owner_ID,Ph_No) VALUES(100003,(9980674554));
insert INTO Owner_Ph(Owner_ID,Ph_No) VALUES(100004,(9780678543));


--Tenant
CREATE TABLE IF NOT EXISTS Tenant(
    Tenant_ID int(6) auto_increment,
    primary key(Tenant_ID),
    F_Name varchar(10) not null,
    L_Name varchar(10) not null,
    Username varchar(10) not null unique,
    Password varchar(10) not null,
    Tenant_Addr varchar(50) default NULL,
    -- constraint fk_tenant_addr foreign key(Tenant_Addr) REFERENCES House(House_Addr),
    DOB date,
    Status boolean default false
);
alter table Tenant auto_increment=300000;


insert INTO Tenant(F_Name,L_Name,Username,Password,Tenant_Addr,DOB) VALUES("Sathvik","A","stvk64","09875","guntur",'2002-04-03');
insert INTO Tenant(F_Name,L_Name,Username,Password,Tenant_Addr,DOB) VALUES("Teja","Kanala","tsreddy43","98735","kurnool",'2002-07-21');
insert INTO Tenant(F_Name,L_Name,Username,Password,Tenant_Addr,DOB) VALUES("Soumith","B","soumpi23","56780","bellary",'2002-01-23');
insert INTO Tenant(F_Name,L_Name,Username,Password,Tenant_Addr,DOB) VALUES("Prathap","P","ptp45","12988","hindupur",'2002-07-09');
insert INTO Tenant(F_Name,L_Name,Username,Password,Tenant_Addr,DOB) VALUES("Nayan","K","nyn987","09876","rajaji nagar,bengaluru",'2002-04-03');

--Tenant_Ph.No
CREATE TABLE IF NOT EXISTS Tenant_Ph(
    Tenant_ID int(6),
    constraint fk_tenant_id foreign key(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    Ph_No char(10) not null
);
alter table Tenant_Ph add constraint check_ph2 check(char_length(Ph_No)=10);

insert INTO Tenant_Ph(Tenant_ID,Ph_No) VALUES(300000,(9067825372));
insert INTO Tenant_Ph(Tenant_ID,Ph_No) VALUES(300001,(6273682936));
insert INTO Tenant_Ph(Tenant_ID,Ph_No) VALUES(300002,(9808577578));
insert INTO Tenant_Ph(Tenant_ID,Ph_No) VALUES(300003,(9768457902));
insert INTO Tenant_Ph(Tenant_ID,Ph_No) VALUES(300020,(6363787893));

--House
CREATE TABLE IF NOT EXISTS House(
    House_ID int auto_increment,
    House_Addr varchar(50),
    primary key(House_ID,House_Addr),
    Htype int(2),
    constraint fk_house_type foreign key(Htype) REFERENCES House_type(Type_No),
    Rent_Cost int(10) not null,
    Owner_ID int(6),
    constraint fk_owner_id2 foreign key(Owner_ID) REFERENCES Owner(Owner_ID)

);
alter table House auto_increment=200000;

INSERT INTO House(House_Addr,Htype,Rent_Cost,Owner_ID) VALUES("Bellary",3,10000,100000);
INSERT INTO House(House_Addr,Htype,Rent_Cost,Owner_ID) VALUES("gauribidanur",2,8000,100001);
INSERT INTO House(House_Addr,Htype,Rent_Cost,Owner_ID) VALUES("puttur",1,7000,100002);
INSERT INTO House(House_Addr,Htype,Rent_Cost,Owner_ID) VALUES("rr nagar",5,15000,100003);
INSERT INTO House(House_Addr,Htype,Rent_Cost,Owner_ID) VALUES("jaynagar",4,20000,100004);

--House_type
CREATE TABLE IF NOT EXISTS House_Type(
    Type_No int(2),
    BHK varchar(6),
    primary key(Type_No,BHK)
);

insert INTO House_Type(Type_No,BHK) VALUES(1,"1 BHK");
insert INTO House_Type(Type_No,BHK) VALUES(2,"2 BHK");
insert INTO House_Type(Type_No,BHK) VALUES(3,"3 BHK");
insert INTO House_Type(Type_No,BHK) VALUES(4,"4 BHK");
insert INTO House_Type(Type_No,BHK) VALUES(5,"5 BHK");

--Payment
CREATE TABLE IF NOT EXISTS Payment(
    Payment_ID int auto_increment,
    primary key(Payment_ID),
    Pay_From varchar(20) not null,
    Payment_Date date,
    Amount int(10) not null,
    Tenant_ID int(6),
    constraint fk_tenant_id3 foreign key(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    Contract_ID int(6),
    constraint fk_contract_id foreign key(Contract_ID) REFERENCES Contract(Contract_ID)
);
alter table Payment auto_increment=500000;

--Contract
CREATE TABLE IF NOT EXISTS Contract(
    Contract_ID int(6) auto_increment,
    primary key(Contract_ID),
    Start_Date date,
    Duration int(2) not null default 1,
    Rent_Cost_Duration int(10), 
    -- constraint fk_rent_cost foreign key(Rent_Cost_Duration) references House(Rent_Cost),
    Owner_ID int(6),
    constraint fk_owner_id3 foreign key(Owner_ID) REFERENCES Owner(Owner_ID),
    Tenant_ID int(6),
    constraint fk_tenant_id2 foreign key(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    House_ID int(6),
    constraint fk_house_id foreign key(House_ID) REFERENCES House(House_ID)
);
alter table Contract auto_increment=400000;




--1.Stored Procedure for Contract_end date
delimiter $

create Procedure end_date_calc(IN start_date date,IN duration int, OUT end_date date)
begin
    select date_add(`start_date`, INTERVAL `duration` MONTH) into end_date;  
end $

delimiter ;

--2.Rent payments updation using triggers,adding how much paid,how much left
DELIMITER $

CREATE FUNCTION rent_remain(Amount double,Total double)
  RETURNS double
   DETERMINISTIC
    BEGIN
     DECLARE remain double;
        return Total-Amount;
    END $
delimiter ;


--3.Tenant address update when status is set to YES when the tenant gets into contract ,get the house_address from the contract house id and set the tenant_addr to Null when status is set to NO
/*Done during the execution phase*/

--4.Set operations union for show con_pay if more than 1 contract_id selected

--5.Join operation of contract and payment when contract_id matches

--6.Aggregate function to show number of payments for 1 contract_id . If multiple contract_id selected then show for different contract_ids(May be make use of group by)

--7.May be add a function to calculate rent_cost_duration from rent_cost and duration(just multiply and return the value)


--8.If Amount in the Payment adds up to total rent cost or exceeds then show the trigger 
        /* c.execute(" drop trigger if exists amount_exceed")
        qrystr = ("""  delimiter // \n"
                "  CREATE TRIGGER mytrigger BEFORE INSERT ON  Payment FOR EACH ROW \n"
                "  BEGIN \n"
                "   IF (select sum(Amount) from Payment group by Contract_ID={}) > {} THEN \n"
                "      SIGNAL SQLSTATE '45000' SET message_text="Amount can't exceed total Rent Cost";\n"
                "   END IF;\n"
                "  END;//\n"
                "  delimiter ; \n""".format(Contract_ID,totalrent))
        c.execute(qrystr)
        mydb.commit() */