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
    
    public partial class GroupIntroduce
    {
        public GroupIntroduce()
        {
            this.Introduces = new HashSet<Introduce>();
        }
    
        public int Id { get; set; }
        public string Vi_GroupName { get; set; }
        public string Eng_GroupName { get; set; }
        public string Ja_GroupName { get; set; }
    
        public virtual ICollection<Introduce> Introduces { get; set; }
    }
}
