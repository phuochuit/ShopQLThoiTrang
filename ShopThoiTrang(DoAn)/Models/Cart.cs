using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using ShopThoiTrang_DoAn_.Models;

namespace ShopThoiTrang_DoAn_.Models
{
    public class Cart
    {
        public List<CartItem> list;
        public Cart()
        {
            list = new List<CartItem>();
        }
        public Cart(List<CartItem> ds)
        {
            list = ds;
        }
        public int SoLuongMatHang()
        {
            return list.Count;
        }
        public int TongSLHang()
        {
            return list.Sum(x => x.SoLuong);
        }
        public decimal TongThanhTien()
        {
            return list.Sum(x => x.ThanhTien);
        }
        public int Them(int id, string size, string mau) 
        {
            try
            {
                CartItem item = list.Find(x => x.MaSP == id && x.Size == size && x.Mau == mau);

                if (item == null)
                {
                    item = new CartItem(id, size, mau);
                    list.Add(item);
                }
                else
                {
                    item.SoLuong++;
                }
                return 1; 
            }
            catch (Exception e)
            {
                return -1;
            }

        }
        public int Giam(int id, string size, string mau) 
        {
            try
            {
                CartItem item = list.Find(x => x.MaSP == id && x.Size == size && x.Mau == mau);

                if (item != null)
                {
                    item.SoLuong--;
                    if (item.SoLuong <= 0)
                    {
                        list.Remove(item); 
                    }
                }
                return 1; 
            }
            catch (Exception e)
            {
                return -1; 
            }

        }
        public int Xoa(int id, string size, string mau) 
        {
            try
            {
                CartItem item = list.Find(x => x.MaSP == id && x.Size == size && x.Mau == mau);

                if (item != null)
                {
                    list.Remove(item); 
                }
                return 1;
            }
            catch (Exception e)
            {
                return -1; 
            }

        }
    }
}