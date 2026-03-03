using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using harry.DAL.Sql.Sql2008;
using NineRays.WebControls;

namespace Tools
{
    /// <summary>树形结构操作类</summary>
    public static class TreeNode
    {
        /// <summary>下拉列表中文件夹的样式</summary>
        private const string style_dir = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_dir.gif'/>  ";
        /// <summary>下拉列表中文件的样式</summary>
        private const string style_file = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_file.gif'/>  ";

        #region ！？基础方法

        /// <summary>为标准格式的树形菜单显示子节点</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        public static void AddNode(FlyTreeNodeCollection nodes, string tname, string parent)
        {
            AddNode(nodes, tname, parent, "", "", 2, false);
        }

        /// <summary>为标准格式的树形菜单显示子节点</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        public static void AddNode(FlyTreeNodeCollection nodes, string tname, string parent, string where)
        {
            AddNode(nodes, tname, parent, where, "", 2, false);
        }

        /// <summary>为标准格式的树形菜单显示子节点</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <param name="expandedLev">节点展开层级</param>
        public static void AddNode(FlyTreeNodeCollection nodes, string tname, string parent, string view, int expandedLev)
        {
            AddNode(nodes, tname, parent, "", view, expandedLev, false);
        }

        /// <summary>为标准格式的树形菜单显示子节点</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddNode(FlyTreeNodeCollection nodes, string tname, string parent, string where, string view, int expandedLev, bool isCheckbox)
        {
            DataTable dt = skin.GetDT(SelectNode(tname, parent, where, view, ""));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes.Add(CreateNode(dt.Rows[i], expandedLev, isCheckbox));
            }
        }

        /// <summary>为标准格式的树形菜单显示子节点</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        /// <param name="order">排序列</param>
        public static void AddNode(FlyTreeNodeCollection nodes, string tname, string parent, string where, string view, int expandedLev, bool isCheckbox, string order)
        {
            DataTable dt = skin.GetDT(SelectNode(tname, parent, where, view, order));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes.Add(CreateNode(dt.Rows[i], expandedLev, isCheckbox));
            }
        }

        /// <summary>？为标准格式的树形菜单插入子节点</summary>
        /// <param name="tname">表名</param>
        /// <param name="request">页面的request对象</param>
        /// <returns>新节点的sole，或错误信息</returns>
        public static string InsertNode(string tname, System.Web.HttpRequest request)
        {
            string result = "";
            try
            {
                string cols = "", values = "";
                string string1 = request["string1"] ?? ""; if (string1 != "") { cols += ",[string1]"; values += ",'" + string1 + "'"; }
                string string2 = request["string2"] ?? ""; if (string2 != "") { cols += ",[string2]"; values += ",'" + string2 + "'"; }
                string int1 = request["int1"] ?? ""; if (int1 != "") { cols += ",[int1]"; values += "," + int1; }
                string int2 = request["int2"] ?? ""; if (int2 != "") { cols += ",[int2]"; values += "," + int2; }

                //插入数据
                StringBuilder sql = new StringBuilder("insert into " + tname + "([parentSole],[name],[createSole],[createDate]" + cols + ") values ('" + (request["ps"] ?? "") + "','" + (request["name"] ?? "") + "','" + AdminBasePage.GetSole() + "','" + AdminBasePage.GetDateTime() + "'" + values + ");");
                sql.Append(harry.Tools.Common.SetSole(tname));//设置sole
                sql.Append(UpdateNode(tname));//设置其他信息
                sql.Append("select ident_current('" + tname + "');");//返回id
                //harry.Tools.Test.Sql.WriteToClipboard(sql.ToString());
                result = skin.ExecuteScalar(sql.ToString()).ToString();
            }
            catch (Exception ex) { result = "Error:" + ex.Message; }
            return result;
        }

        /// <summary>获取查询节点的sql语句：显示状态、子节点数</summary>
        /// <param name="tname">表名</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <returns>select sql</returns>
        public static string SelectNode(string tname, string parent, string where, string view, string order)
        {
            return @"select *,name1" +
                (view.IndexOf("used") > -1 ? "+'  <a style=''color:'+(case isUsed when 1 then 'green''>√' else 'red''>Χ' end)+'</a>' " : "") + @"" +
                (view.IndexOf("child") > -1 ? "+(case childCount when '0' then '' else ' &nbsp;&nbsp;&nbsp;&nbsp;<a class=''child''>('+cast(childCount as varchar)+')</a>' end)" : "") + @" as name from 
                (
                    select top 9999 p.sole,p.parentSole as pparent,p.name as name1,p.path,p.indexs,p.isUsed,p.lev,(case when childCount is null then '0' else cast(childCount as varchar) end) as childCount  
                    from " + tname + @" as p left join 
                    (
                        select t2.id as t2id,count(t1.id) as childCount from " + tname + @" as t1," + tname + @" as t2 where t1.parentSole=t2.sole " + (parent == "" ? "" : " and t2.parentSole='" + parent + "' ") + @" group by t2.id
                    ) as t3
                    on t3.t2id=p.id " + (parent == "" ? "" : " where parentSole='" + parent + "' ") + (order != "" ? " order by " + order : "") + @"
                ) as t4 " + where + " order by indexs".Replace("  ", "");
        }

        /// <summary>获取code字段集合对应的所有上层节点编号集合（去重后）</summary>
        /// <param name="sql">sql</param>
        /// <returns>上层节点编号集合</returns>
        public static string ReckonNode(string sql)
        {
            List<string> soles = new List<string>();
            try
            {
                DataTable dt = skin.GetDT(sql);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string code = dt.Rows[i][0].ToString();
                    if (code != "")
                    {
                        soles.AddRange(code.Split('-'));
                    }
                }
                soles = soles.Distinct().ToList();
            }
            catch { throw; }
            return "'" + string.Join("','", soles.ToArray()) + "'";
        }

        /// <summary>获取设置节点信息的update语句：path=路径、code=编码串、lev=等级</summary>
        /// <param name="tname">表名</param>
        /// <returns>update sql</returns>
        public static string UpdateNode(string tname)
        {
            return @"update " + tname + @" set path=t1.path,code=t1.code,lev=t1.lev+1 from 
                    (
	                    select top 99999 child.sole,(case patent.lev when 0 then patent.name else patent.path+'-'+patent.name end) as path,patent.code+'-'+child.sole as code,patent.lev 
	                    from " + tname + @" as patent," + tname + @" as child  
	                    where child.parentSole=patent.sole and child.id=ident_current('" + tname + @"') 
                    ) as t1
                    where " + tname + @".sole=t1.sole and " + tname + @".id=ident_current('" + tname + @"');";
        }

        /// <summary>创建新节点：节点是否有子节点由数据库子节点数量决定</summary>
        /// <param name="row">数据行</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        /// <returns>新节点</returns>
        public static FlyTreeNode CreateNode(DataRow row, int expandedLev, bool isCheckbox)
        {
            FlyTreeNode node = new FlyTreeNode();
            var columns = row.Table.Columns;
            if (columns.Contains("name")) { node.Text = row["name"].ToString(); }
            if (columns.Contains("sole")) { node.Value = row["sole"].ToString(); }
            if (columns.Contains("path")) { node.ToolTip = row["path"].ToString(); }
            if (columns.Contains("indexs")) { node.DragDropName = row["indexs"].ToString(); }
            if (columns.Contains("childCount")) { node.PopulateNodesOnDemand = row["childCount"].ToString() != "0"; }
            if (columns.Contains("lev")) { node.Expanded = int.Parse(row["lev"].ToString()) < expandedLev; }
            node.IsCheckbox = isCheckbox;
            return node;
        }

        /// <summary>创建新节点：节点是否有子节点由参数指定</summary>
        /// <param name="row">数据行</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        /// <param name="populate">节点是否有子节点</param>
        /// <returns>新节点</returns>
        public static FlyTreeNode CreateNode(DataRow row, int expandedLev, bool isCheckbox, bool populate)
        {
            FlyTreeNode node = new FlyTreeNode();
            var columns = row.Table.Columns;
            if (columns.Contains("name")) { node.Text = row["name"].ToString(); }
            if (columns.Contains("sole")) { node.Value = row["sole"].ToString(); }
            if (columns.Contains("path")) { node.ToolTip = row["path"].ToString(); }
            if (columns.Contains("indexs")) { node.DragDropName = row["indexs"].ToString(); }
            node.PopulateNodesOnDemand = populate;
            if (columns.Contains("lev")) { node.Expanded = int.Parse(row["lev"].ToString()) < expandedLev; }
            node.IsCheckbox = isCheckbox;
            return node;
        }

        #endregion

        #region ！添加操作系统目录、文件

        /// <summary>添加文件目录</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="path">文件夹相对路径</param>
        /// <param name="expandedLev">节点展开层级</param>
        public static void AddDirectory(FlyTreeNodeCollection nodes, string path, int expandedLev)
        {
            AddDirectory(nodes, path, expandedLev, false);
        }

        /// <summary>添加文件目录</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="path">文件夹相对路径</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddDirectory(FlyTreeNodeCollection nodes, string path, int expandedLev, bool isCheckbox)
        {
            string[] dirs = Directory.GetDirectories(AppDomain.CurrentDomain.BaseDirectory + path);
            foreach (string dir in dirs)
            {
                string d = dir.Replace(@"\", @"/"); d = d.Substring(d.LastIndexOf(@"/") + 1);
                FlyTreeNode node1 = new FlyTreeNode();
                node1.Text = style_dir + d;
                node1.Value = path + "/" + d;
                node1.ToolTip = "文件夹";
                node1.Expanded = node1.Level < expandedLev;
                node1.IsCheckbox = isCheckbox;
                nodes.Add(node1);
                //递归文件夹
                AddDirectory(node1.ChildNodes, node1.Value, expandedLev, isCheckbox);
            }
        }

        /// <summary>添加目录、文件</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="path">文件夹相对路径</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddFile(FlyTreeNodeCollection nodes, string path, int expandedLev, bool isCheckbox)
        {
            string[] dirs = Directory.GetDirectories(AppDomain.CurrentDomain.BaseDirectory + path);
            foreach (string dir in dirs)
            {
                string d = dir.Replace(@"\", @"/"); d = d.Substring(d.LastIndexOf(@"/") + 1);
                FlyTreeNode node1 = new FlyTreeNode();
                node1.Text = style_dir + d;
                node1.Value = path + "/" + d;
                node1.ToolTip = "文件夹";
                node1.Expanded = node1.Level < expandedLev;
                node1.IsCheckbox = isCheckbox;
                nodes.Add(node1);
                //递归文件夹
                AddDirectory(node1.ChildNodes, node1.Value, expandedLev, isCheckbox);
            }

            FileInfo[] files = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + path).GetFiles();
            foreach (var f in files)
            {
                FlyTreeNode node2 = new FlyTreeNode();
                node2.Text = style_file + f.Name;
                node2.ToolTip = "文件";
                nodes.Add(node2);
            }
        }

        #endregion

        #region ！添加管理员

        /// <summary>以机构添加管理员</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="expandedLev">节点展开层级</param>
        public static void AddManagerByOrgan(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev)
        {
            DataTable dt1 = skin.GetDT(SelectNode("[admin_organ]", parent, " where isUsed=1 ", "", ""));
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                dt1.Rows[i]["path"] = "机构";
                FlyTreeNode node1 = CreateNode(dt1.Rows[i], expandedLev, true);
                DataTable dt2 = skin.GetDT(@"select sole,name,name as path from [admin_per_manager] where organSole='" + node1.Value + "' " + ((System.Web.HttpContext.Current.Request["t"] ?? "") != "" ? " and type='" + System.Web.HttpContext.Current.Request["t"] + "'" : "") + " " + where + " order by id");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    dt2.Rows[j]["path"] = "账号";
                    node1.ChildNodes.Add(CreateNode(dt2.Rows[j], 0, true));
                }
                nodes.Add(node1);
            }
        }

        /// <summary>以类型添加管理员</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddManagerByType(FlyTreeNodeCollection nodes, string where)
        {
            DataTable dt1 = skin.GetDT("select name from admin_per_managerType where isUsed=1 order by id");
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                FlyTreeNode node1 = new FlyTreeNode(dt1.Rows[i]["name"].ToString(), dt1.Rows[i]["name"].ToString());
                node1.ToolTip = "类型";
                node1.Expanded = true;
                DataTable dt2 = skin.GetDT(@"select sole,name,name as path from [admin_per_manager] where type='" + dt1.Rows[i]["name"] + "' " + where + " order by id");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    dt2.Rows[j]["path"] = "账号";
                    node1.ChildNodes.Add(new FlyTreeNode(dt2.Rows[j]["name"].ToString(), dt2.Rows[j]["sole"].ToString()));
                }
                nodes.Add(node1);
            }
        }

        #endregion

        #region ！添加行政区域

        /// <summary>添加行政区域</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        public static void AddArea(FlyTreeNodeCollection nodes, string parent, string view)
        {
            AddArea(nodes, parent, "", view, 1, false);
        }

        /// <summary>添加行政区域</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddArea(FlyTreeNodeCollection nodes, string parent, string where, string view, int expandedLev, bool isCheckbox)
        {
            DataTable dt = skin.GetDT(SelectNode("data_area", parent, where, view, ""));
            if (where.IndexOf("and lev<=") == -1)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    nodes.Add(CreateNode(dt.Rows[i], expandedLev, isCheckbox));
                }
            }
            else
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    nodes.Add(CreateNode(dt.Rows[i], expandedLev, isCheckbox, false));
                }
            }
        }

        #endregion

        #region ！添加方案信息

        /// <summary>添加方案根目录（所有方案）</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="managerSole">管理员编号</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddPlans(FlyTreeNodeCollection nodes, string managerSole, bool isCheckbox)
        {
            string sql = "select t1.sole from [publish_plan] as t1 ";
            sql += managerSole == "" ? " where t1.id>0 " : " right join [admin_per_manager_plan] as p1 on t1.sole=p1.planSole where p1.managerSole='" + managerSole + "' and p1.planType='root' ";
            DataTable dt = skin.GetDT(sql + " and t1.isUsed=1");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //添加方案根目录
                AddPlan(nodes, managerSole, dt.Rows[i]["sole"].ToString(), "", isCheckbox);
            }
        }

        /// <summary>添加方案根目录（指定方案）</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="managerSole">管理员编号</param>
        /// <param name="planSole">方案编号</param>
        /// <param name="where">页面查询条件</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddPlan(FlyTreeNodeCollection nodes, string managerSole, string planSole, string where, bool isCheckbox)
        {
            string sql = "select t1.name from [publish_plan] as t1 ";
            sql += managerSole == "" ? " where t1.id>0 " : " right join [admin_per_manager_plan] as p1 on t1.sole=p1.planSole where p1.managerSole='" + managerSole + "' and p1.planType='root' ";
            string pname = skin.ExecuteScalar(sql + " and t1.sole='" + planSole + "'").ToString();
            if (pname != "")
            {
                FlyTreeNode node = new FlyTreeNode();
                node.Text = pname;
                node.Value = planSole;
                node.ToolTip = "root";
                node.Expanded = true;
                node.IsCheckbox = isCheckbox;

                //添加方案目录、页面
                AddPlanPage(node.ChildNodes, managerSole, planSole, "-1", where, 0, isCheckbox);
                nodes.Add(node);
            }
        }

        /// <summary>添加方案的目录、页面</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="managerSole">管理员编号</param>
        /// <param name="planSole">方案编号</param>
        /// <param name="parentSole">父节点编号</param>
        /// <param name="where">查询条件</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddPlanPage(FlyTreeNodeCollection nodes, string managerSole, string planSole, string parentSole, string where, int expandedLev, bool isCheckbox)
        {
            string sql = "select t1.name,t1.sole,t1.type from [publish_planPage] as t1";
            sql += managerSole == "" ? " where t1.id>0 " : " right join [admin_per_manager_plan] as p1 on t1.sole=p1.planSole where p1.managerSole='" + managerSole + "' and p1.planType in ('dir','file','custom1') ";
            DataTable dt = skin.GetDT(sql + "and t1.planSole='" + planSole + "' and t1.parentSole='" + parentSole + "' and t1.lev=" + expandedLev + " and t1.isUsed=1 " + where + " order by t1.indexs");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                FlyTreeNode node = new FlyTreeNode();
                node.Text = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_" + dt.Rows[i]["type"] + ".gif'/>  " + dt.Rows[i]["name"].ToString();
                node.Value = dt.Rows[i]["sole"].ToString();
                node.ToolTip = dt.Rows[i]["type"].ToString();
                node.Expanded = false;
                node.IsCheckbox = isCheckbox;

                //递归加载
                AddPlanPage(node.ChildNodes, managerSole, planSole, dt.Rows[i]["sole"].ToString(), where, expandedLev + 1, isCheckbox);
                nodes.Add(node);
            }
        }

        /// <summary>添加方案的页面元素</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="eleSole">页面编号</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddPageElement(FlyTreeNodeCollection nodes, string eleSole, bool isCheckbox)
        {
            DataTable dt = skin.GetDT("select name,sole from [publish_planDetail] where pageSole=(select pageSole from [publish_planDetail] where sole='" + eleSole + "')");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                FlyTreeNode node = new FlyTreeNode();
                node.IsCheckbox = isCheckbox;
                node.Text = dt.Rows[i]["name"].ToString();
                node.Value = dt.Rows[i]["sole"].ToString();
                nodes.Add(node);
            }
        }

        #endregion

        #region ！添加设备

        ///// <summary>以分类添加设备</summary>
        ///// <param name="nodes">父节点</param>
        ///// <param name="parent">父节点编号</param>
        ///// <param name="where">附加查询条件</param>
        ///// <param name="expandedLev">节点展开层级</param>
        ///// <param name="isCheckbox">是否单选框</param>
        //public static void AddEquipmentByType(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev, bool isCheckbox)
        //{
        //    DataTable dt1 = skin.GetDT(SelectNode("[publish_equipmentType]", parent, " where isUsed=1 ", ""));
        //    for (int i = 0; i < dt1.Rows.Count; i++)
        //    {
        //        FlyTreeNode node1 = CreateNode(dt1.Rows[i], expandedLev, isCheckbox);
        //        DataTable dt2 = skin.GetDT(@"select e1.sole,e1.name from [publish_equipment_group] as t1 left join [publish_equipment] as e1 on t1.managerSole=e1.sole where t1.groupSole='" + node1.Value + "' " + ((System.Web.HttpContext.Current.Request["t"] ?? "") != "" ? " and e1.typeSole='" + System.Web.HttpContext.Current.Request["t"] + "'" : "") + " " + where + " order by t1.id");
        //        for (int j = 0; j < dt2.Rows.Count; j++)
        //        {
        //            FlyTreeNode node2 = new FlyTreeNode();
        //            node2.IsCheckbox = true;
        //            node2.Text = dt2.Rows[j]["name"].ToString();
        //            node2.Value = dt2.Rows[j]["sole"].ToString();
        //            node2.ToolTip = dt2.Rows[j]["name"].ToString();
        //            node1.ChildNodes.Add(node2);
        //        }
        //        nodes.Add(node1);
        //    }
        //}

        /// <summary>以单个机构添加设备</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox1">机构是否单选框</param>
        /// <param name="isCheckbox2">设备是否单选框</param>
        /// <param name="checked2">设备是否被选中</param>
        public static void AddEquipmentByOrgan(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev, bool isCheckbox1, bool isCheckbox2, bool checked2)
        {
            DataTable dt1 = skin.GetDT(SelectNode("[admin_organ]", parent, " where isUsed=1 " + where, "", ""));
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                FlyTreeNode node1 = CreateNode(dt1.Rows[i], expandedLev, isCheckbox1);
                string typeSole = ((System.Web.HttpContext.Current.Request["tsole"] ?? "") != "" ? " and typeSole='" + System.Web.HttpContext.Current.Request["tsole"] + "'" : "");
                string system = ((System.Web.HttpContext.Current.Request["system"] ?? "") != "" ? " and system='" + System.Web.HttpContext.Current.Request["system"] + "'" : "");
                DataTable dt2 = skin.GetDT(@"select sole,name from publish_equipment where organSole='" + node1.Value + "' " + typeSole + system + " order by id");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    FlyTreeNode node2 = new FlyTreeNode();
                    node2.IsCheckbox = isCheckbox2;
                    node2.Text = dt2.Rows[j]["name"].ToString();
                    node2.Value = dt2.Rows[j]["sole"].ToString();
                    node2.ToolTip = "设备";
                    node2.Checked = checked2;
                    node1.ChildNodes.Add(node2);
                }
                nodes.Add(node1);
            }
        }

        /// <summary>以复数机构添加设备</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox1">机构是否单选框</param>
        /// <param name="isCheckbox2">设备是否单选框</param>
        /// <param name="checked2">设备是否被选中</param>
        public static void AddEquipmentByOrgans(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev, bool isCheckbox1, bool isCheckbox2, bool checked2)
        {
            DataTable dt1 = skin.GetDT(SelectNode("[admin_organ]", parent, " where isUsed=1 " + where, "", ""));
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                FlyTreeNode node1 = CreateNode(dt1.Rows[i], expandedLev, isCheckbox1);
                string typeSole = ((System.Web.HttpContext.Current.Request["tsole"] ?? "") != "" ? " and typeSole in('" + (System.Web.HttpContext.Current.Request["tsole"] ?? "").ToString().Replace(",", "','") + "')" : "");
                string system = ((System.Web.HttpContext.Current.Request["system"] ?? "") != "" ? " and system='" + System.Web.HttpContext.Current.Request["system"] + "'" : "");
                DataTable dt2 = skin.GetDT(@"select sole,name from publish_equipment where organSole='" + node1.Value + "' " + typeSole + system + " order by id");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    FlyTreeNode node2 = new FlyTreeNode();
                    node2.IsCheckbox = isCheckbox2;
                    node2.Text = dt2.Rows[j]["name"].ToString();
                    node2.Value = dt2.Rows[j]["sole"].ToString();
                    node2.ToolTip = "设备";
                    node2.Checked = checked2;
                    node1.ChildNodes.Add(node2);
                }
                nodes.Add(node1);
            }
        }

        #endregion

        #region 添加目录、素材

        /// <summary>添加目录、素材</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        public static void AddDir(FlyTreeNodeCollection nodes, string parent)
        {
            AddDir(nodes, parent, " where isUsed=1 ", "", 5, false);
        }

        /// <summary>添加目录、素材</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="view">附加显示内容：used=使用状态、child=子节点数量</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddDir(FlyTreeNodeCollection nodes, string parent, string where, string view, int expandedLev, bool isCheckbox)
        {
            DataTable dt = skin.GetDT(SelectNode("[publish_filesDirectory]", parent, where, view, ""));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                FlyTreeNode node1 = new FlyTreeNode();
                node1.Text = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_dir.gif'/>  " + dt.Rows[i]["name"].ToString();
                node1.Value = dt.Rows[i]["sole"].ToString();
                node1.ToolTip = "目录";
                node1.Expanded = int.Parse(dt.Rows[i]["lev"].ToString()) < expandedLev;
                node1.IsCheckbox = isCheckbox;
                nodes.Add(node1);
                //递归调用
                AddDir(node1.ChildNodes, node1.Value, where, view, expandedLev, isCheckbox);
            }
        }

        /// <summary>添加目录、素材</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="parent">父节点编号</param>
        /// <param name="where">附加查询条件</param>
        /// <param name="expandedLev">节点展开层级</param>
        /// <param name="isCheckbox">是否单选框</param>
        public static void AddFileByDir(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev, bool isCheckbox)
        {
            DataTable dt1 = skin.GetDT(SelectNode("[publish_filesDirectory]", parent, " where isUsed=1 ", "", ""));
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                //添加目录
                FlyTreeNode node1 = new FlyTreeNode();
                node1.Text = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_dir.gif'/>  " + dt1.Rows[i]["name"].ToString();
                node1.Value = dt1.Rows[i]["sole"].ToString();
                node1.ToolTip = "目录";
                node1.Expanded = int.Parse(dt1.Rows[i]["lev"].ToString()) < expandedLev;
                node1.IsCheckbox = isCheckbox;

                //添加文件
                DataTable dt2 = skin.GetDT(@"select sole,name from [publish_files] where dirSole='" + node1.Value + "' " + where + " order by id");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    FlyTreeNode node2 = new FlyTreeNode();
                    node2.Text = "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_file.gif'/>  " + dt2.Rows[j]["name"].ToString();
                    node2.Value = dt2.Rows[j]["sole"].ToString();
                    node2.ToolTip = "素材";
                    node2.Expanded = false;
                    node2.IsCheckbox = isCheckbox;
                    node1.ChildNodes.Add(node2);
                }
                nodes.Add(node1);
                //递归调用
                AddFileByDir(node1.ChildNodes, node1.Value, where, expandedLev, isCheckbox);
            }
        }

        #endregion

        #region 添加区域的菜单信息

        /// <summary>添加区域</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="pageSole">页面编号</param>
        /// <param name="detailSole">区域编号</param>
        public static void AddDetail(FlyTreeNodeCollection nodes, string pageSole, string detailSole)
        {
            string dname = skin.ExecuteScalar("select name from [publish_planDetail] where sole='" + detailSole + "'").ToString();
            if (dname != "")
            {
                FlyTreeNode node = new FlyTreeNode();
                node.Text = dname;
                node.Value = "-1";
                node.ToolTip = "root";
                node.Expanded = true;

                //添加方案目录、页面
                AddDetailMenus(node.ChildNodes, pageSole, detailSole, "-1");
                nodes.Add(node);
            }
        }

        /// <summary>添加菜单信息</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="pageSole">页面编号</param>
        /// <param name="detailSole">区域编号</param>
        /// <param name="parentSole">父节点编号</param>
        public static void AddDetailMenus(FlyTreeNodeCollection nodes, string pageSole, string detailSole, string parentSole)
        {
            DataTable dt = skin.GetDT("select name,sole,type from [publish_planMenus] where parentSole='" + parentSole + "' and int1=" + pageSole + " and int2=" + detailSole);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                FlyTreeNode node = new FlyTreeNode();
                node.Text = dt.Rows[i]["name"].ToString();
                node.Value = dt.Rows[i]["sole"].ToString();
                node.ToolTip = dt.Rows[i]["type"].ToString();
                node.Expanded = false;
                //node.IsCheckbox = isCheckbox;

                //递归加载
                AddDetailMenus(node.ChildNodes, pageSole, detailSole, dt.Rows[i]["sole"].ToString());
                nodes.Add(node);
            }
        }

        #endregion

        #region 以类型添加场景

        /// <summary>以类型添加场景</summary>
        /// <param name="nodes">父节点</param>
        /// <param name="where">where条件</param>
        public static void AddSceneByLev(FlyTreeNodeCollection nodes, string where)
        {
            DataTable dt1 = skin.GetDT("select distinct type from scene_info" + where);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                FlyTreeNode node1 = new FlyTreeNode(dt1.Rows[i]["type"].ToString(), dt1.Rows[i]["type"].ToString());
                node1.ToolTip = "类型";
                node1.Expanded = true;
                DataTable dt2 = skin.GetDT(@"select sole,name,name as path from [scene_info] where type='" + dt1.Rows[i]["type"] + "' order by index1");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    dt2.Rows[j]["path"] = "账号";
                    node1.ChildNodes.Add(new FlyTreeNode(dt2.Rows[j]["name"].ToString(), dt2.Rows[j]["sole"].ToString()));
                }
                nodes.Add(node1);
            }
        }

        #endregion


        //#region ！添加理财经理

        ///// <summary>以机构添加理财经理</summary>
        ///// <param name="nodes">父节点</param>
        ///// <param name="parent">父节点编号</param>
        ///// <param name="where">附加查询条件</param>
        ///// <param name="expandedLev">节点展开层级</param>
        //public static void AddFinancialByOrgan(FlyTreeNodeCollection nodes, string parent, string where, int expandedLev)
        //{
        //    DataTable dt1 = skin.GetDT(SelectNode("[admin_organ]", parent, " where isUsed=1 ", "", ""));
        //    for (int i = 0; i < dt1.Rows.Count; i++)
        //    {
        //        dt1.Rows[i]["path"] = "机构";
        //        FlyTreeNode node1 = CreateNode(dt1.Rows[i], expandedLev, false);
        //        DataTable dt2 = skin.GetDT(@"select sole,name,name as path from [client_financial] where organSole='" + node1.Value + "' " + ((System.Web.HttpContext.Current.Request["t"] ?? "") != "" ? " and type='" + System.Web.HttpContext.Current.Request["t"] + "'" : "") + " " + where + " order by id");
        //        for (int j = 0; j < dt2.Rows.Count; j++)
        //        {
        //            dt2.Rows[j]["path"] = "经理";
        //            node1.ChildNodes.Add(CreateNode(dt2.Rows[j], 0, true));
        //        }
        //        nodes.Add(node1);
        //    }
        //}

        //#endregion

        //#region ！添加客户

        ///// <summary>以机构添加客户</summary>
        ///// <param name="nodes">父节点</param>
        ///// <param name="fSole">经理编号</param>
        //public static void AddMenber(FlyTreeNodeCollection nodes, string fSole)
        //{
        //    FlyTreeNode root = new FlyTreeNode();
        //    root.Text = "全部客户";
        //    root.Value = "";
        //    root.ToolTip = "";
        //    //root.DragDropName = "";
        //    //root.PopulateNodesOnDemand = true;
        //    root.Expanded = true;
        //    root.IsCheckbox = true;

        //    string sql = string.Empty;
        //    if (fSole == "") { sql = "select t1.sole,t1.name,t1.mobile,fv1.fSole from client_member as t1 left join client_financial_vip as fv1 on t1.sole=fv1.vSole where t1.isUsed=1"; }
        //    else { sql = "select t1.sole,t1.name,t1.mobile,(case when fv1.fSole='" + fSole + "' then fv1.fSole else '' end) as fSole from client_member as t1 left join client_financial_vip as fv1 on t1.sole=fv1.vSole where t1.isUsed=1 and (fv1.fSole='" + fSole + "' or fv1.fSole is null)"; }

        //    DataTable dt1 = skin.GetDT(sql);
        //    for (int i = 0; i < dt1.Rows.Count; i++)
        //    {
        //        FlyTreeNode node1 = new FlyTreeNode();
        //        node1.Text = dt1.Rows[i]["name"].ToString();
        //        node1.Value = dt1.Rows[i]["sole"].ToString();
        //        node1.ToolTip = "客户";
        //        node1.IsCheckbox = true;
        //        node1.Checked = dt1.Rows[i]["fSole"].ToString() != "";
        //        root.ChildNodes.Add(node1);
        //    }

        //    nodes.Add(root);
        //}

        //#endregion


        //#region ！添加公司

        ///// <summary></summary>
        ///// <param name="nodes"></param>
        ///// <param name="parent"></param>
        ///// <param name="where"></param>
        ///// <param name="expandedLev"></param>
        //public static void AddCompanyByLev(FlyTreeNodeCollection nodes, string where)
        //{
        //    DataTable dt1 = skin.GetDT("select distinct lev from student_info");
        //    for (int i = 0; i < dt1.Rows.Count; i++)
        //    {
        //        FlyTreeNode node1 = new FlyTreeNode(dt1.Rows[i]["lev"].ToString(), dt1.Rows[i]["lev"].ToString());
        //        node1.ToolTip = "环保管理层级";
        //        node1.Expanded = true;
        //        DataTable dt2 = skin.GetDT(@"select sole,name,name as path from [student_info] where lev='" + dt1.Rows[i]["lev"] + "' " + where + " order by id");
        //        for (int j = 0; j < dt2.Rows.Count; j++)
        //        {
        //            dt2.Rows[j]["path"] = "学员";
        //            node1.ChildNodes.Add(new FlyTreeNode(dt2.Rows[j]["name"].ToString(), dt2.Rows[j]["sole"].ToString()));
        //        }
        //        nodes.Add(node1);
        //    }
        //}

        //#endregion
    }
}