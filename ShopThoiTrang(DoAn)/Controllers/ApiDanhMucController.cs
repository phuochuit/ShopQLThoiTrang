using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ShopThoiTrang_DoAn_.Models;

namespace ShopThoiTrang_DoAn_.Controllers
{
    public class ApiDanhMucController : ApiController
    {
        NHOM8_DOANEntities db = new NHOM8_DOANEntities();
        [HttpGet]
        public IHttpActionResult GetDanhMucs()
        {
            db.Configuration.LazyLoadingEnabled = false;

            try
            {
                var list = db.DanhMucs.Select(x => new
                {
                    x.MaDM,
                    x.TenDM,
                    MaDMChinh = x.MaDMChinh
                }).ToList();

                return Ok(list); 
            }
            catch (Exception ex)
            {
                return InternalServerError(ex); 
            }
        }

        [HttpGet]
        public IHttpActionResult GetChiTiet(int id)
        {
            var item = db.DanhMucs.Select(x => new
            {
                x.MaDM,
                x.TenDM,
                x.MaDMChinh
            }).FirstOrDefault(x => x.MaDM == id);

            if (item == null) return NotFound(); 
            return Ok(item);
        }


        [HttpPost]
        public IHttpActionResult ThemMoi([FromBody] DanhMuc dm)
        {
            if (!ModelState.IsValid)
                return BadRequest("Dữ liệu không hợp lệ");

            try
            {
                var newDM = new DanhMuc();
                newDM.TenDM = dm.TenDM;
                newDM.MaDMChinh = dm.MaDMChinh;

                db.DanhMucs.Add(newDM);
                db.SaveChanges();

                return Ok(new { success = true, message = "Thêm thành công", id = newDM.MaDM });
            }
            catch (Exception ex)
            {
                return BadRequest("Lỗi server: " + ex.Message);
            }
        }

        [HttpPut]
        public IHttpActionResult CapNhat(int id, [FromBody] DanhMuc dm)
        {
            var item = db.DanhMucs.Find(id);
            if (item == null) return NotFound();

            try
            {
                item.TenDM = dm.TenDM;
                item.MaDMChinh = dm.MaDMChinh;

                db.SaveChanges();
                return Ok(new { success = true, message = "Cập nhật thành công" });
            }
            catch (Exception ex)
            {
                return BadRequest("Lỗi khi sửa: " + ex.Message);
            }
        }

        [HttpDelete]
        public IHttpActionResult Xoa(int id)
        {
            var item = db.DanhMucs.Find(id);
            if (item == null) return NotFound();

            try
            {
                bool coSanPham = db.SanPhams.Any(x => x.MaDM == id);
                if (coSanPham)
                {
                    return Content(HttpStatusCode.BadRequest, new { message = "Không thể xóa: Danh mục này đang chứa sản phẩm!" });
                }

                bool coDanhMucCon = db.DanhMucs.Any(x => x.MaDMChinh == id);
                if (coDanhMucCon)
                {
                    return Content(HttpStatusCode.BadRequest, new { message = "Không thể xóa: Danh mục này đang là cha của danh mục khác!" });
                }

                db.DanhMucs.Remove(item);
                db.SaveChanges();
                return Ok(new { success = true, message = "Xóa thành công" });
            }
            catch (Exception ex)
            {
                return BadRequest("Lỗi khi xóa: " + ex.Message);
            }
        }
    }
}