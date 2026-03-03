using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_scene_1scene_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //排序
            for (int i = 1; i < 100; i++) { index1.Items.Add(i.ToString()); }

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from scene_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());
                    ViewState.Add("image1", dt.Rows[0]["image1"].ToString());
                    ViewState.Add("image2", dt.Rows[0]["image2"].ToString());
                    ViewState.Add("image3", dt.Rows[0]["image3"].ToString());
                    ViewState.Add("image4", dt.Rows[0]["image4"].ToString());
                    ViewState.Add("image5", dt.Rows[0]["image5"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    type.SelectedValue = dt.Rows[0]["type"].ToString();
                    lev.SelectedValue = dt.Rows[0]["lev"].ToString();
                    index1.SelectedValue = dt.Rows[0]["index1"].ToString();
                    intro.Text = dt.Rows[0]["intro"].ToString();

                    string _saveURL1 = dt.Rows[0]["image1"].ToString();
                    if (_saveURL1 != "")
                    {
                        path1.Text = "<a href='" + _saveURL1 + "' target='_blank'>文件地址：" + _saveURL1 + "</a>";
                        Image1.Visible = true;
                        Image1.ImageUrl = _saveURL1;
                    }
                    string _saveURL2 = dt.Rows[0]["image2"].ToString();
                    if (_saveURL2 != "")
                    {
                        path2.Text = "<a href='" + _saveURL2 + "' target='_blank'>文件地址：" + _saveURL2 + "</a>";
                        Image2.Visible = true;
                        Image2.ImageUrl = _saveURL2;
                    }
                    string _saveURL3 = dt.Rows[0]["image3"].ToString();
                    if (_saveURL3 != "")
                    {
                        path3.Text = "<a href='" + _saveURL3 + "' target='_blank'>文件地址：" + _saveURL3 + "</a>";
                        Image3.Visible = true;
                        Image3.ImageUrl = _saveURL3;
                    }
                    string _saveURL4 = dt.Rows[0]["image4"].ToString();
                    if (_saveURL4 != "")
                    {
                        path4.Text = "<a href='" + _saveURL4 + "' target='_blank'>文件地址：" + _saveURL4 + "</a>";
                        Image4.Visible = true;
                        Image4.ImageUrl = _saveURL4;
                    }
                    string _saveURL5 = dt.Rows[0]["image5"].ToString();
                    if (_saveURL5 != "")
                    {
                        path5.Text = "<a href='" + _saveURL5 + "' target='_blank'>文件地址：" + _saveURL5 + "</a>";
                        Image5.Visible = true;
                        Image5.ImageUrl = _saveURL5;
                    }

                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();

                    string sceneSole = dt.Rows[0]["sole"].ToString();
                    //关联客户画像
                    System.Text.StringBuilder html1 = new System.Text.StringBuilder();
                    DataTable dt1 = skin.GetDT("select * from member_info where sceneSole='" + sceneSole + "'");
                    if (dt1.Rows.Count > 0)
                    {
                        html1.Append("<table class='table table-bordered table-hover'>");
                        //html1.Append("  <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>个人客户</td></tr>");
                        html1.Append("  <tr><th>排序</th><th>编号</th><th>姓名</th><th>合约</th><th>价值</th><th>年龄</th><th>流量</th><th>资费</th><th>融合</th><th>视频</th><th>权益</th><th>职业</th><th>地域</th></tr>");
                        html1.Append("  <tbody>");
                        for (int i = 0; i < dt1.Rows.Count; i++)
                        {
                            html1.Append("<tr>");
                            html1.Append("<td>"+(i + 1).ToString()+"</td>");
                            html1.Append("<td>" + dt1.Rows[i]["sole"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["name"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing1"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing2"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing3"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing4"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing5"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing6"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing7"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing8"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing9"] + "</td>");
                            html1.Append("<td>" + dt1.Rows[i]["shuxing10"] + "</td>");
                            html1.Append("</tr>");
                        }
                        html1.Append("  </tbody>");
                        html1.Append("</table>");
                    }
                    member_html.InnerHtml = html1.ToString();
                    
                    //关联产品
                    System.Text.StringBuilder html2 = new System.Text.StringBuilder();

                    html2.Append("<table class='table table-bordered table-hover'>");
                    //html2.Append("  <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>产品信息</td></tr>");
                    html2.Append("  <tr><th>排序</th><th>编号</th><th>名称</th><th>档位</th></tr>");//<th>简介</th>
                    html2.Append("  <tbody>");

                    string p1 = dt.Rows[0]["produceSole1"].ToString();
                    if (p1 != "")
                    {
                        DataTable dt2 = skin.GetDT("select * from produce_info where sole='" + p1 + "'");
                        if (dt2.Rows.Count > 0)
                        {
                            html2.Append("<tr>");
                            html2.Append("<td>1、</td>");
                            html2.Append("<td>" + dt2.Rows[0]["sole"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["name"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["lev"] + "</td>");
                            //html2.Append("<td>" + dt2.Rows[0]["intro"] + "</td>");
                            html2.Append("</tr>");
                        }
                    }
                    string p2 = dt.Rows[0]["produceSole2"].ToString();
                    if (p2 != "")
                    {
                        DataTable dt2 = skin.GetDT("select * from produce_info where sole='" + p2 + "'");
                        if (dt2.Rows.Count > 0)
                        {
                            html2.Append("<tr>");
                            html2.Append("<td>2、</td>");
                            html2.Append("<td>" + dt2.Rows[0]["sole"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["name"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["lev"] + "</td>");
                            //html2.Append("<td>" + dt2.Rows[0]["intro"] + "</td>");
                            html2.Append("</tr>");
                        }
                    }
                    string p3 = dt.Rows[0]["produceSole3"].ToString();
                    if (p3 != "")
                    {
                        DataTable dt2 = skin.GetDT("select * from produce_info where sole='" + p3 + "'");
                        if (dt2.Rows.Count > 0)
                        {
                            html2.Append("<tr>");
                            html2.Append("<td>3、</td>");
                            html2.Append("<td>" + dt2.Rows[0]["sole"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["name"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["lev"] + "</td>");
                            //html2.Append("<td>" + dt2.Rows[0]["intro"] + "</td>");
                            html2.Append("</tr>");
                        }
                    }
                    string p4 = dt.Rows[0]["produceSole4"].ToString();
                    if (p4 != "")
                    {
                        DataTable dt2 = skin.GetDT("select * from produce_info where sole='" + p4 + "'");
                        if (dt2.Rows.Count > 0)
                        {
                            html2.Append("<tr>");
                            html2.Append("<td>4、</td>");
                            html2.Append("<td>" + dt2.Rows[0]["sole"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["name"] + "</td>");
                            html2.Append("<td>" + dt2.Rows[0]["lev"] + "</td>");
                            //html2.Append("<td>" + dt2.Rows[0]["intro"] + "</td>");
                            html2.Append("</tr>");
                        }
                    }

                    html2.Append("  </tbody>");
                    html2.Append("</table>");



                    //DataTable dt2 = skin.GetDT("select * from produce_info where sceneSole='" + sceneSole + "'");
                    //if (dt2.Rows.Count > 0)
                    //{
                    //    html2.Append("<table class='table table-bordered table-hover'>");
                    //    html2.Append("  <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>产品信息</td></tr>");
                    //    html2.Append("  <tr><th>排序</th><th>编号</th><th>名称</th><th>档位</th><th>简介</th></tr>");
                    //    html2.Append("  <tbody>");
                    //    for (int i = 0; i < dt2.Rows.Count; i++)
                    //    {
                    //        html2.Append("<tr>");
                    //        html2.Append("<td>"+(i + 1).ToString()+"</td>");
                    //        html2.Append("<td>" + dt2.Rows[i]["sole"] + "</td>");
                    //        html2.Append("<td>" + dt2.Rows[i]["name"] + "</td>");
                    //        html2.Append("<td>" + dt2.Rows[i]["intro"] + "</td>");
                    //        html2.Append("</tr>");
                    //    }
                    //    html2.Append("  </tbody>");
                    //    html2.Append("</table>");
                    //}
                    produce_html.InnerHtml = html2.ToString();
                }
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (name.Text == "") { this.Alert("请输入场景名称"); name.Focus(); return; }
        //上传图片1
        if (FileUpload1.HasFile)
        {
            string name1 = "*.jpg/*.png";
            string name2 = FileUpload1.PostedFile.FileName; name2 = name2.Substring(name2.LastIndexOf("."));
            if (name1.IndexOf(name2) == -1) { this.Alert("无效的素材文件，图片要求 [ " + name1 + " ] 类型文件"); return; }
        }
        //上传图片2
        if (FileUpload2.HasFile)
        {
            string name1 = "*.jpg/*.png";
            string name2 = FileUpload2.PostedFile.FileName; name2 = name2.Substring(name2.LastIndexOf("."));
            if (name1.IndexOf(name2) == -1) { this.Alert("无效的素材文件，图片要求 [ " + name1 + " ] 类型文件"); return; }
        }
        //上传图片3
        if (FileUpload3.HasFile)
        {
            string name1 = "*.jpg/*.png";
            string name2 = FileUpload3.PostedFile.FileName; name2 = name2.Substring(name2.LastIndexOf("."));
            if (name1.IndexOf(name2) == -1) { this.Alert("无效的素材文件，图片要求 [ " + name1 + " ] 类型文件"); return; }
        }
        //上传图片4
        if (FileUpload4.HasFile)
        {
            string name1 = "*.jpg/*.png";
            string name2 = FileUpload4.PostedFile.FileName; name2 = name2.Substring(name2.LastIndexOf("."));
            if (name1.IndexOf(name2) == -1) { this.Alert("无效的素材文件，图片要求 [ " + name1 + " ] 类型文件"); return; }
        }
        //上传图片5
        if (FileUpload5.HasFile)
        {
            string name1 = "*.jpg/*.png";
            string name2 = FileUpload5.PostedFile.FileName; name2 = name2.Substring(name2.LastIndexOf("."));
            if (name1.IndexOf(name2) == -1) { this.Alert("无效的素材文件，图片要求 [ " + name1 + " ] 类型文件"); return; }
        }

        ArrayList sql = new ArrayList();
        string _saveURL1 = !FileUpload1.HasFile ? (oper == "add" ? "" : ViewState["image1"].ToString()) : harry.Tools.IO.FileEx.GetFilePath("/Upload/scene/", FileUpload1, true, true);
        string _saveURL2 = !FileUpload2.HasFile ? (oper == "add" ? "" : ViewState["image2"].ToString()) : harry.Tools.IO.FileEx.GetFilePath("/Upload/scene/", FileUpload2, true, true);
        string _saveURL3 = !FileUpload3.HasFile ? (oper == "add" ? "" : ViewState["image3"].ToString()) : harry.Tools.IO.FileEx.GetFilePath("/Upload/scene/", FileUpload3, true, true);
        string _saveURL4 = !FileUpload4.HasFile ? (oper == "add" ? "" : ViewState["image4"].ToString()) : harry.Tools.IO.FileEx.GetFilePath("/Upload/scene/", FileUpload4, true, true);
        string _saveURL5 = !FileUpload5.HasFile ? (oper == "add" ? "" : ViewState["image5"].ToString()) : harry.Tools.IO.FileEx.GetFilePath("/Upload/scene/", FileUpload5, true, true);

        //分值
        int[] points = { 10, 15, 20 };
        //发送sql
        if (oper == "add")
        {
            sql.Add(@"insert into scene_info values('','" + type.SelectedValue + "','" + name.Text + "','" + lev.SelectedValue + "'," + points[lev.SelectedIndex] + "," + index1.SelectedValue + ",'" + intro.Text + "','" + _saveURL1 + "','" + _saveURL2 + "','" + _saveURL3 + "','" + _saveURL4 + "','" + _saveURL5 + "','','','',''," + (isUsed.Checked ? 1 : 0) + ",0,'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("scene_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [scene_info] set [type]='" + type.SelectedValue + "',[name]='" + name.Text + "',[lev]='" + lev.SelectedValue + "',[point]=" + points[lev.SelectedIndex] + ",[index1]='" + index1.SelectedValue + "',[intro]='" + intro.Text + "',[image1]='" + _saveURL1 + "',[image2]='" + _saveURL2 + "',[image3]='" + _saveURL3 + "',[image4]='" + _saveURL4 + "',[image5]='" + _saveURL5 + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }
        bool result = skin.Transaction(sql);
        if (result)
        {
            if (FileUpload1.HasFile)
            {
                //保存文件
                harry.Tools.IO.FileEx.SaveFile(_saveURL1, FileUpload1, oper == "add" ? "" : ViewState["image1"].ToString());
                ViewState["image1"] = _saveURL1;
                //缓存信息
                path1.Text = "<a href='" + _saveURL1 + "' target='_blank'>文件地址：" + _saveURL1 + "</a>";
                Image1.Visible = true;
                Image1.ImageUrl = _saveURL1;
            }
            if (FileUpload2.HasFile)
            {
                //保存文件
                harry.Tools.IO.FileEx.SaveFile(_saveURL2, FileUpload2, oper == "add" ? "" : ViewState["image2"].ToString());
                ViewState["image2"] = _saveURL2;
                //缓存信息u
                path2.Text = "<a href='" + _saveURL2 + "' target='_blank'>文件地址：" + _saveURL2 + "</a>";
                Image2.Visible = true;
                Image2.ImageUrl = _saveURL2;
            }
            if (FileUpload3.HasFile)
            {
                //保存文件
                harry.Tools.IO.FileEx.SaveFile(_saveURL3, FileUpload3, oper == "add" ? "" : ViewState["image3"].ToString());
                ViewState["image3"] = _saveURL3;
                //缓存信息u
                path2.Text = "<a href='" + _saveURL3 + "' target='_blank'>文件地址：" + _saveURL3 + "</a>";
                Image3.Visible = true;
                Image3.ImageUrl = _saveURL3;
            }
            if (FileUpload4.HasFile)
            {
                //保存文件
                harry.Tools.IO.FileEx.SaveFile(_saveURL4, FileUpload4, oper == "add" ? "" : ViewState["image4"].ToString());
                ViewState["image4"] = _saveURL4;
                //缓存信息u
                path2.Text = "<a href='" + _saveURL4 + "' target='_blank'>文件地址：" + _saveURL4 + "</a>";
                Image4.Visible = true;
                Image4.ImageUrl = _saveURL4;
            }
            if (FileUpload5.HasFile)
            {
                //保存文件
                harry.Tools.IO.FileEx.SaveFile(_saveURL5, FileUpload5, oper == "add" ? "" : ViewState["image5"].ToString());
                ViewState["image5"] = _saveURL5;
                //缓存信息u
                path2.Text = "<a href='" + _saveURL5 + "' target='_blank'>文件地址：" + _saveURL5 + "</a>";
                Image5.Visible = true;
                Image5.ImageUrl = _saveURL5;
            }
        }
        this.AlertSubmit(result);
    }
}