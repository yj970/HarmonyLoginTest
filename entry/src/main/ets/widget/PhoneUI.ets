/**
 * 1.provide与consume的使用例子
 */

@Component
export struct PhoneUI{
  @Consume phone :string;
  build(){
    Text(this.phone).fontColor(Color.Brown).onClick(()=>{
      this.phone = '999';
    })
  }
}