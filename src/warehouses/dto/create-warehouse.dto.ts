import { IsInt, IsString } from 'class-validator';

export class CreateWarehouseDto {
  @IsString()
  name: string;
  @IsInt()
  quantity: number;
}
