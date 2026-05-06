-- Tạo một procedure in ra thông tin sinh viên ;
-- Định nghĩa procedure
DELIMITER //
CREATE PROCEDURE sp_inrathongtinsinhvien ()
BEGIN
	-- Logic xử lý
    SELECT * FROM sinhvien;
END
// DELIMITER ;

-- Gọi procedure
CALL sp_inrathongtinsinhvien();

-- Tạo một procedure nhận vào tham số là mã sinh viên 
-- và in ra thông tin sinh viên đó 

DELIMITER //
CREATE PROCEDURE sp_inthongtinsinhviencuthe(
	IN p_masv VARCHAR(5)
)
BEGIN
	SELECT * FROM sinhvien AS sv
    WHERE sv.masv = p_masv;
END
// DELIMITER ;

CALL sp_inthongtinsinhviencuthe("SV001")

-- Tạo một hàm in ra điểm trung bình của từng sinh viên 
DELIMITER //
CREATE PROCEDURE sp_indiemtrungbinh()
BEGIN
	SELECT masv , AVG(diem) FROM diem
    GROUP BY masv;
END
// DELIMITER ;

CALL sp_indiemtrungbinh();
-- HÀM nhận vào mã sinh viên - trả về học lực của sinh viên 
-- "Xuất sắc" điểm trung bình : > 9 
-- "GIỏi" điểm trung bình >8 và < 9
-- "Khá" điểm trung bình từ 6 đến 8 
-- Còn lại thì học lực "yếu"

DELIMITER //
CREATE PROCEDURE sp_thongtinhoclucsinhviencuthe(
	IN p_masv VARCHAR(10),
    OUT p_hocluc VARCHAR(20)
)
BEGIN
	-- Khai báo biến tạm thời 
	DECLARE diemTrungBinh FLOAT ;
    
	SELECT AVG(diem) INTO diemTrungBinh
    FROM diem
    WHERE masv = p_masv;
    
    IF diemTrungBinh > 9 THEN
		SET p_hocluc = "Xuất Sắc";
	ELSEIF diemTrungBinh > 8 THEN 
		SET p_hocluc = "Giỏi";
	ELSEIF diemTrungBinh > 6 THEN 
		SET p_hocluc = "Khá";
	ELSE
		SET p_hocluc = "Yếu";
	END IF;
END
// DELIMITER ;

SET @thongtinhocluc = "";

CALL sp_thongtinhoclucsinhviencuthe("SV001", @thongtinhocluc);
SELECT @thongtinhocluc;
