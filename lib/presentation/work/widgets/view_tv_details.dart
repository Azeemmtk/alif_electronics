import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/work/widgets/customer_tv_details_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewTvDetails extends StatelessWidget {
  const ViewTvDetails({
    super.key,
    required this.data,
  });

  final WorkModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TV Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerTVDetailsColumn(
                data: data,
                head: 'Brand and Model',
                value: '${data.brandName} ${data.modelNumber}',
              ),
              CustomerTVDetailsColumn(
                data: data,
                head: 'Complaint',
                value: data.complaint,
              ),
              Row(
                children: [
                  CustomerTVDetailsColumn(
                    data: data,
                    head: data.status == 'Completed'
                        ? 'Completed on'
                        : 'Due date',
                    value:
                    '${data.expectedDate.day}-${data.expectedDate.month}-${data.expectedDate.year}',
                  ),
                  SizedBox(
                    width: 130.w,
                  ),
                  CustomerTVDetailsColumn(
                      data: data,
                      head: 'Expected rate',
                      value: '₹${data.expectedAmount}/-')
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
