//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VTSolution.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Digital
    {
        public int Id { get; set; }
        public string Vi_Name { get; set; }
        public string Eng_Name { get; set; }
        public string Vi_Value { get; set; }
        public string Eng_Value { get; set; }
        public Nullable<int> IdProduct { get; set; }
        public Nullable<int> IdParent { get; set; }
        public string Ja_Name { get; set; }
        public string Ja_Value { get; set; }
    
        public virtual Feature Feature { get; set; }
        public virtual Product Product { get; set; }
    }
}
