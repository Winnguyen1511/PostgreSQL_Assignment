-- create database
-- -- create database Assignment3_Database;
use assignment3_database;

-- create tables:
-- 1) CONGDAN


create table CONGDAN
(
    MaCD        char(5),
    HoTenCD     VARCHAR(30),
    DiaChi      VARCHAR(40),
    ToDanPho    VARCHAR(20),
    GioiTinh    char(3),
    HoTenChuHo  VARCHAR(30),
    QuanHeVoiChuHo  VARCHAR(20),
    constraint PK_CONGDAN_MaCD
    PRIMARY KEY(MaCD) 
);

-- 2) LOAITHUTUC

create table LOAITHUTUC
(
    MaLoaiTT    CHAR(5),
    TenLoaiTT   VARCHAR(30),
    ThoiHanTraKetQuaToiDa int,
    MucPhi      money,
    constraint  PK_LOAITHUTUC_MaLoaiTT
    primary key (MaLoaiTT)
);

-- -- 3) CANBOTIEPNHAN

create table CANBOTIEPNHAN
(
    MaCBTN  CHAR(5),
    HoTenCBTN   CHAR(7),
    constraint  PK_CANBOTIEPNHAN_MaCBTN
    PRIMARY KEY(MaCBTN)
);

-- alter TABLE canbotiepnhan
-- add ChucVu  VARCHAR(40);
-- -- 4) YEUCAUTHUTUC

create table YEUCAUTHUTUC
(
    MaYeuCau    CHAR(7),
    MaCD        CHAR(5),
    NoiDungYeuCau   VARCHAR(40),
    MaLoaiTT    char(5),
    ThoiDiemTaoYeuCau   TIMESTAMP,
    ThoiDiemHenTraKetQua    TIMESTAMP,
    MaCBTN      CHAR(5),
    TrangThai   VARCHAR(40),
    constraint  PK_YEUCAUTHUTUC_MaYeuCau
    PRIMARY KEY(MaYeuCau)
);

-- 5) GIAYTOKEMTHEO

create table GIAYTOKEMTHEO
(
    MaYeuCau    CHAR(7),
    TenGiayToKemTheo    VARCHAR(40),
    MoTaGiayToKemTheo   TEXT,
    ThoiDiemNhanGTKT    TIMESTAMP,
    constraint  PK_GIAYTOKEMTHEO_MaYeuCau_TenGiayToKemTheo
    PRIMARY KEY(MaYeuCau, TenGiayToKemTheo)
);

-- 6) GIAYTOCANBOSUNG
create table GIAYTOCANBOSUNG
(
    MaYeuCau    CHAR(7),
    TenGiayToCanBoSung  VARCHAR(40),
    MoTaGiayToCanBoSung TEXT,
    ThoiHanCuoiCungDeBoSung TIMESTAMP,
    TinhTrangBoSung     varchar(40),
    constraint  PK_GIAYTOCANBOSUNG_MaYeuCau_TenGiayToCanBoSung
    PRIMARY KEY(MaYeuCau, TenGiayToCanBoSung)
);


-- Add Foreign Key:
-- 1) CONGDAN
-- 2) LOAITHUTUC
-- 3) CANBOTIEPNHAN
-- 4) YEUCAUTHUTUC
-- FK_YEUCAUTHUTUC_CONGDAN_ MaCD
alter TABLE YEUCAUTHUTUC
add constraint FK_YEUCAUTHUTUC_CONGDAN_MaCD
foreign key(MaCD) references CONGDAN(MaCD);

-- FK_YEUCAUTHUTUC_LOAITHUTUC_MaLoaiTT
alter TABLE YEUCAUTHUTUC
add constraint FK_YEUCAUTHUTUC_LOAITHUTUC_MaLoaiTT
foreign key(MaLoaiTT) references LOAITHUTUC(MaLoaiTT);
-- FK_YEUCAUTHUTUC_CANBOTIEPNHAN_MaCBTN
alter TABLE YEUCAUTHUTUC
add constraint FK_YEUCAUTHUTUC_CANBOTIEPNHAN_MaCBTN
foreign key(MaCBTN) references CANBOTIEPNHAN(MaCBTN);

-- -- FK_YEUCAUTHUTUC_GIAYTOCANBOSUNG_MaYeuCau
-- alter TABLE YEUCAUTHUTUC
-- ADD constraint FK_YEUCAUTHUTUC_GIAYTOCANBOSUNG_MaYeuCau
-- foreign key(MaYeuCau) references GIAYTOCANBOSUNG(MaYeuCau);

-- alter TABLE YEUCAUTHUTUC
-- drop foreign key FK_YEUCAUTHUTUC_GIAYTOCANBOSUNG_MaYeuCau;

-- 5) GIAYTOKEMTHEO
-- FK_GIAYTOKEMTHEO_YEUCAUTHUTUC_MaYeuCau
alter table GIAYTOKEMTHEO
add constraint FK_GIAYTOKEMTHEO_YEUCAUTHUTUC_MaYeuCau
foreign key(MaYeuCau) references YEUCAUTHUTUC(MaYeuCau);
-- 6) GIAYTOCANBOSUNG
-- FK_GIAYTOCANBOSUNG_YEUCAUTHUTUC_MaYeuCau

alter TABLE GIAYTOCANBOSUNG
add constraint FK_GIAYTOCANBOSUNG_YEUCAUTHUTUC_MaYeuCau
foreign key(MaYeuCau) references YEUCAUTHUTUC(MaYeuCau);


-- ALTER TABLE giaytocanbosung
-- DROP CONSTRAINT FK_GIAYTOCANBOSUNG_YEUCAUTHUTUC_MaYeuCau;
-- alter TABLE GIAYTOCANBOSUNG
-- add MaYeuCau CHAR(7);
-- Simulate data:

-- 1) CONGDAN
insert into CONGDAN 
(MaCD, HoTenCD, DiaChi, ToDanPho, GioiTinh, HoTenChuHo, QuanHeVoiChuHo)
VALUES
(
    'CD001',
    'Tran A1',
    '10 Nguyen Du',
    'To 1',
    'Nam',
    'Nguyen Van 1',
    'Ban than'
);

insert into CONGDAN
(MaCD, HoTenCD, DiaChi, ToDanPho, GioiTinh, HoTenChuHo, QuanHeVoiChuHo)
VALUES
(
    'CD002',
    'Tran A2',
    '11 Nguyen Du',
    'To 2',
    'Nu',
    'Nguyen Van 2',
    'Chong'
);

insert into CONGDAN
(MaCD, HoTenCD, DiaChi, ToDanPho, GioiTinh, HoTenChuHo, QuanHeVoiChuHo)
VALUES
(
    'CD003',
    'Tran A3',
    '12 Nguyen Du',
    'To 3',
    'Nam',
    'Nguyen Van 3',
    'Vo'
);

-- 2) LOAITHUTUC:
insert into LOAITHUTUC
(MaLoaiTT, TenLoaiTT, ThoiHanTraKetQuaToiDa, MucPhi)
VALUES
(
    'TT001',
    'Dang ky ket hon',
    2,
    15000
);

insert into LOAITHUTUC
(MaLoaiTT, TenLoaiTT, ThoiHanTraKetQuaToiDa, MucPhi)
VALUES
(
    'TT002',
    'Khai sinh',
    7,
    20000
);

-- 3) CANBOTIEPNHAN:
insert into CANBOTIEPNHAN
(MaCBTN, HoTenCBTN, ChucVu)
VALUES
(
    'CB001',
    'CBTN001',
    'Nhan vien thoi vu'
);

insert into CANBOTIEPNHAN
(MaCBTN, HoTenCBTN, ChucVu)
VALUES
(
    'CB002',
    'CBTN002',
    'Can bo ho tich'
);

-- 4) YEUCAUTHUTUC:
insert into YEUCAUTHUTUC
(MaYeuCau, MaCD, NoiDungYeuCau, MaLoaiTT, ThoiDiemTaoYeuCau, ThoiDiemHenTraKetQua, MaCBTN, TrangThai)
VALUES
(
    'YC00001',
    'CD001',
    'Khai sinh cho con',
    'TT002',
    '2019-02-15 07:50:00',
    '2019-02-25 13:00:00',
    'CB001',
    'Da tiep nhan xu ly'
);

insert into YEUCAUTHUTUC
(MaYeuCau, MaCD, NoiDungYeuCau, MaLoaiTT, ThoiDiemTaoYeuCau, ThoiDiemHenTraKetQua, MaCBTN, TrangThai)
VALUES
(
    'YC00002',
    'CD002',
    'Khai tu cho me',
    'TT001',
    '2019-02-15 07:10:00',
    NULL,
    'CB002',
    'Cong dan moi dang ky'
);


-- 5) GIAYTOKEMTHEO:
insert into GIAYTOKEMTHEO
VALUES
(
    'YC00001',
    'Giay dang ki ket hon',
    'Giay dang ki ket hon cua cha me',
    '2019-02-15 07:50:00'
);

insert into GIAYTOKEMTHEO
VALUES
(
    'YC00001',
    'Ho khau',
    'Ho khau thuong tru',
    '2019-02-15 07:50:00'
);

-- 6) GIAYTOCANBOSUNG:
insert into GIAYTOCANBOSUNG
VALUES
(
    'YC00002',
    'Chung minh nhan dan',
    'Ban sao CMND',
    '2019-02-15 07:50:00',
    'Dang yeu cau bo sung'
);

insert into GIAYTOCANBOSUNG
VALUES
(
    'YC00002',
    'Giay khai sinh',
    'Giay khai sinh nguoi khai',
    '2019-03-15 07:50:00',
    'Da duoc bo sung'
);
