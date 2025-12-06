using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ShopThoiTrang_DoAn_.Models;

namespace ShopThoiTrang_DoAn_.Models
{
    public class CartItem
    {
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public string Size { get; set; }
        public string Mau { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia { get; set; }
        public int SoLuong { get; set; }
        public decimal ThanhTien
        {
            get
            {
                return Gia * SoLuong;
            }
        }
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();

        public CartItem(int id, string size, string mau)
        {
            SanPham item = db.SanPhams.FirstOrDefault(x => x.MaSP == id);
            var bienThe = db.BienTheSanPhams.FirstOrDefault(x => x.MaSP == id && x.Size == size);
            if (item != null)
            {
                MaSP = item.MaSP;
                TenSP = item.TenSP;
                SoLuong = 1;
                AnhDaiDien = item.AnhDaiDien;
                Size = size;

                Mau = bienThe?.Mau ?? "Không xác định";

                Gia = item.Gia.Value;
            }
        }
    }
}