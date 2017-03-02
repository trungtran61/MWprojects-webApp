using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using myBiz.DAL;

namespace webApp.Common
{
    public class clsTemplateField : ITemplate
    {
        private clsColumn _xCol;
        private string _Type;
        public clsTemplateField(string colType, clsColumn cl) { _Type = colType; _xCol = cl; }
        public void InstantiateIn(Control container)
        {
            switch (_Type)
            {
                case "Literal":
                    Literal lit = new Literal { ID = string.Format("lit{0}", _xCol.colName) };
                    lit.DataBinding += new EventHandler(xDB);
                    container.Controls.Add(lit);
                    break;
                case "LnkPopup":
                    Literal lPopup = new Literal { ID = string.Format("litPopup{0}", _xCol.colName) };
                    lPopup.DataBinding += new EventHandler(xDB);
                    container.Controls.Add(lPopup);
                    break;
                case "N/A":
                    container.Controls.Add(new Literal { Text = "N/A" });
                    break;
                case "ChkAllBox":
                    container.Controls.Add(new Literal { Text = _xCol.colName });
                    break;
                case "CheckBox":
                    container.Controls.Add(new CheckBox { ID = string.Format("chk{0}", _xCol.colName) });
                    break;
                case "TextBox":
                    TextBox txt = new TextBox { ID = string.Format("txt{0}", _xCol.colName), Width = Unit.Pixel(_xCol.fieldWidth) };
                    txt.DataBinding += new EventHandler(xDB);
                    container.Controls.Add(txt);
                    break;
                case "LinkSelect":
                    LinkButton lnk = new LinkButton { ID = string.Format("lnk{0}", _xCol.colName), CommandName = "Select" };
                    lnk.DataBinding += new EventHandler(xDB);
                    container.Controls.Add(lnk);
                    break;
                case "Command":
                    var q = from i in _xCol.colName.Split(',')
                            where !string.IsNullOrEmpty(i)
                            let j = i.Split(':')
                            select new { Text = j[0], CommandName = j[1] };
                    foreach (var k in q)
                    {
                        container.Controls.Add(new Button
                        {
                            ID = string.Format("btn{0}", k.CommandName),
                            Text = k.Text,
                            CommandName = k.CommandName,
                            OnClientClick = k.CommandName.Equals("Delete") ? "return confirm('Are you sure you want to delete?');" : string.Empty,
                            ToolTip = k.CommandName,
                            CssClass = "NavBtn"
                        });
                        container.Controls.Add(new Literal { Text = "&nbsp;" });
                    }
                    break;
            }

            if (!string.IsNullOrEmpty(_xCol.addHF))
            {
                HiddenField hf = new HiddenField { ID = string.Format("hf{0}", _xCol.addHF) };
                hf.DataBinding += new EventHandler(hfDataBinding);
                container.Controls.Add(hf);
            }
        }

        private void hfDataBinding(object sender, EventArgs e)
        {
            object dVal = DataBinder.Eval(((sender as Control).NamingContainer as GridViewRow).DataItem, _xCol.addHF);
            if (dVal != null) (sender as HiddenField).Value = dVal.ToString();
        }

        private void xDB(object sender, EventArgs e)
        {
            object dVal = DataBinder.Eval(((sender as Control).NamingContainer as GridViewRow).DataItem, _xCol.colName);

            if (dVal != null)
            {
                switch (_Type)
                {
                    case "Literal": (sender as Literal).Text = _xCol.strFormat != null ? string.Format(_xCol.strFormat, dVal) : dVal.ToString(); break;
                    case "LnkPopup":
                        string lnk = "<a href=\"{1}\">{0}</a>";
                        (sender as Literal).Text = string.Format(lnk, _xCol.strFormat != null ? string.Format(_xCol.strFormat, dVal) : dVal.ToString(),
                            _xCol.lnkPopup.Replace("[[Ln]]", DataBinder.Eval(((sender as Control).NamingContainer as GridViewRow).DataItem, "Ln").ToString()));
                        break;
                    case "TextBox": (sender as TextBox).Text = dVal.ToString(); break;
                    case "LinkSelect": (sender as LinkButton).Text = _xCol.strFormat != null ? string.Format(_xCol.strFormat, dVal) : dVal.ToString(); break;
                }
            }
        }
    }
}