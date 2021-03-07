CREATE TABLE roles
(
    authority    VARCHAR(50) NOT NULL PRIMARY KEY,
    description  VARCHAR(100) NOT NULL
) ENGINE = InnoDb;

CREATE TABLE users
(
    username   VARCHAR(50)  NOT NULL PRIMARY KEY,
    password   VARCHAR(255) NOT NULL,
    enabled                 BOOLEAN DEFAULT TRUE

) ENGINE = InnoDb;
-- auth
create table authorities
(
    username  varchar(50) not null,
    authority varchar(50) not null,
    foreign key (username) references users (username),
    primary key (username, authority)
) engine = innodb;

create table groups
(
    id       BIGINT(50) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_name  varchar(50) not null
) engine = innodb;

create table group_members
(
    username  varchar(50) not null,
    group_id     BIGINT(50) NOT NULL,
    foreign key (username) references users (username),
    foreign key (group_id) references groups (id),
    primary key (username,group_id)
) engine = innodb;

create table group_authorities
(
    group_id     BIGINT(50) NOT NULL,
    authority    varchar(50) not null,
    foreign key (group_id) references groups (id),
    primary key (group_id, authority)
) engine = innodb;

-- spring session
create table spring_session (
	primary_id char(36) not null,
	session_id char(36) not null,
	creation_time bigint not null,
	last_access_time bigint not null,
	max_inactive_interval int not null,
	expiry_time bigint not null,
	principal_name varchar(100),
	constraint spring_session_pk primary key (primary_id)
) engine=innodb row_format=dynamic;

create unique index spring_session_ix1 on spring_session (session_id);
create index spring_session_ix2 on spring_session (expiry_time);
create index spring_session_ix3 on spring_session (principal_name);

create table spring_session_attributes (
	session_primary_id char(36) not null,
	attribute_name varchar(200) not null,
	attribute_bytes blob not null,
	constraint spring_session_attributes_pk primary key (session_primary_id, attribute_name),
	constraint spring_session_attributes_fk foreign key (session_primary_id) references spring_session(primary_id) on delete cascade
) engine=innodb row_format=dynamic;

---

create table revinfo (
    rev       BIGINT(50) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    revtstmp  BIGINT(50),
    username  VARCHAR(50)
);

---

INSERT INTO roles
(authority, description)
VALUES
('ROLE_ADMIN'  ,'Administrator')
;

INSERT INTO users
(enabled,username              ,password )
VALUES
(true  , 'user@ramdan.com'   ,'{noop}rahasia')
;


INSERT INTO authorities
(authority     ,username)
VALUES
('ROLE_ADMIN'  ,'user@ramdan.com')

;


