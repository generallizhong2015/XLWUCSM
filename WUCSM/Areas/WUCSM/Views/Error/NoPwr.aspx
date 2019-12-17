<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    没有权限！
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellspacing="0" cellpadding="0" align="center" border="0" class="EMessageTable">
        <tbody>
            <tr>
                <td height="330">
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <div class="font14" align="center">
                        <h2 style="text-align: center; font-size: 16px; font-weight: bold; margin-bottom: 10px;
                            color: #7f7f7f;">
                            没有权限！</h2>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
</asp:Content>
