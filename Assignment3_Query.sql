-- 1) Delete CD with ToDanPho = 13
start Transaction;

-- Delete from GIAYTOKEMTHEO
-- USING GIAYTOKEMTHEO
-- inner join YEUCAUTHUTUC on GIAYTOKEMTHEO.MaYeuCau = YEUCAUTHUTUC.MaYeuCau
-- inner join CONGDAN on YEUCAUTHUTUC.MaCD = CONGDAN.MaCD
-- where CONGDAN.ToDanPho = 'To 3';

DELETE from giaytokemtheo as GTKT
USING YEUCAUTHUTUC as YCTT, CONGDAN as CD
WHERE GTKT.mayeucau = YCTT.MaYeuCau
and   YCTT.MaCD = CD.MaCD
and CD.ToDanPho = 'To 3';

-- delete GIAYTOCANBOSUNG
-- from GIAYTOCANBOSUNG
-- inner join YEUCAUTHUTUC on GIAYTOCANBOSUNG.MaYeuCau = YEUCAUTHUTUC.MaYeuCau
-- inner join CONGDAN on YEUCAUTHUTUC.MaCD = CONGDAN.MaCD
-- where CONGDAN.ToDanPho = 'To 3';

DELETE from GIAYTOCANBOSUNG as GTCBS
using YEUCAUTHUTUC as YCTT, CONGDAN as CD
WHERE GTCBS.MaYeuCau = YCTT.MaYeuCau
and CD.MaCD = YCTT.maCD
and CD.ToDanPho = 'To 3';

-- delete YEUCAUTHUTUC
-- from YEUCAUTHUTUC
-- INNER JOIN CONGDAN on YEUCAUTHUTUC.MaCD = CONGDAN.MaCD
-- where CONGDAN.ToDanPho = 'To 3';

DELETE from YEUCAUTHUTUC as YCTT
using CONGDAN as CD
where YCTT.MaCD = CD.MaCD
and CD.ToDanPho = 'To 3';

delete from CONGDAN
where ToDanPho = 'To 3';
rollback;

-- start transaction;
-- delete GIAYTOCANBOSUNG from GIAYTOCANBOSUNG 
-- where MaYeuCau = 'YC00002';
-- rollback;

-- 2)Cập nhật những loại thủ tục có thời hạn trả kết quả tối đa là 2 (ngày) thành 5
start transaction;
update LOAITHUTUC
Set ThoiHanTraKetQuaToiDa = 5
WHERE ThoiHanTraKetQuaToiDa <= 2;
rollback;

-- 3)Liệt kê những công dân có họ tên bắt đầu là ký tự 'Ng', kết thúc bằng ký tự 'g' và
-- có độ dài tối đa là 50 ký tự (kể cả ký tự trắng).

select * from CONGDAN
where HoTenCD like 'Ng%'
and LENGTH(HoTenCD) <= 50;

-- 4) Liệt kê những yêu cầu có thời điểm tạo nằm trong năm 2016 hoặc năm 2019.
select * from YEUCAUTHUTUC
where date_part('year',ThoiDiemTaoYeuCau) =2016
or date_part('year',ThoiDiemTaoYeuCau) = 2019; 

-- 5) Liệt kê MaYeuCau, MaCD, NoiDungYeuCau, ThoiDiemTaoYeuCau,
-- ThoiDiemHenTraKetQua, TrangThai của tất cả những yêu cầu có trạng thái là "Da tiep
-- nhan xu ly". Kết quả hiển thị được sắp xếp giảm dần theo MaCD và tăng dần theo
-- ThoiDiemHenTraKetQua.

select MaYeuCau, MaCD, NoiDungYeuCau, ThoiDiemTaoYeuCau, ThoiDiemHenTraKetQua, TrangThai
from YEUCAUTHUTUC 
where TrangThai = 'Da tiep nhan xu ly'
ORDER by MaCD desc;

-- 6) Liệt kê những cán bộ có chức vụ là "Can bo ho tich" và chưa từng tiếp nhận bất
-- kỳ một yêu cầu nào của công dân.

select * from CANBOTIEPNHAN
where ChucVu = 'Can bo ho tich'
and MaCBTN not in (
    select CBTN.MaCBTN 
    from CANBOTIEPNHAN as CBTN, YEUCAUTHUTUC as YCTT
    WHERE CBTN.MaCBTN = YCTT.MaCBTN
);

-- 7) Liệt kê họ tên của những công dân đang có trong hệ thống. Nếu họ tên trùng nhau
-- thì chỉ hiển thị 1 lần. Sinh viên cần thực hiện yêu cầu này bằng 2 cách khác nhau (mỗi
-- cách được tính 0.5 điểm).

select HoTenCD from CONGDAN
group by HoTenCD;

-- 8)  Liệt kê MaCD, HoTenCD, MaYeuCau, NoiDungYeuCau, TrangThai của tất cả
-- công dân trong hệ thống

select CONGDAN.MaCD, HoTenCD, MaYeuCau, NoiDungYeuCau, TrangThai
from CONGDAN
left join YEUCAUTHUTUC on CONGDAN.MaCD = YEUCAUTHUTUC.MaCD;

-- 9) Liệt kê những công dân là chủ hộ và đã từng tạo ít nhất 10 yêu cầu khác nhau
-- trong nửa đầu năm 2019

select * from CONGDAN
inner join YEUCAUTHUTUC on CONGDAN.MaCD = YEUCAUTHUTUC.MaCD
where CONGDAN.HoTenCD in 
(
    select HoTenChuHo from CONGDAN
);

-- 10) Liệt kê những công dân đã từng tạo yêu cầu có loại thủ tục là 'Chung nhan doc
-- than' và chưa từng tạo yêu cầu nào thuộc loại thủ tục có tên là 'Dang ky ket hon' trong
-- tháng 10 năm 2019.

select * from CONGDAN
where MaCD in 
(
    select MaCD from YEUCAUTHUTUC
    where NoiDungYeuCau = 'Chung nhan doc than'
    and NoiDungYeuCau <> 'Dang ky ket hon'
    and date_part('year', ThoiDiemTaoYeuCau) = 2019
    and date_part('month', ThoiDiemTaoYeuCau) = 10
);