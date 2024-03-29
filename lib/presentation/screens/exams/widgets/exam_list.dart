import 'package:flutter/material.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../../../../core/utils/insets.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import 'exam_item.dart';

class ExamList extends StatelessWidget {

  final TeacherExam? exams;
  final TeacherBank? banks;
  const ExamList({super.key, required this.exams, required this.banks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        const SizedBox(height: 4.0,),
        exams?.unsolvedTest == null && exams?.shortOne == null && exams?.shortTwo == null && exams?.finalReview == null ? Container() : SizedBox(
          width: double.infinity,
          child: Text(
            AppStrings.exams,
            style: getLargeStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0,),
        isWide(context) ? _buildExamsGrid(context, exams) : _buildExamsList(exams),
        const SizedBox(height: 16.0,),
        banks?.solvedBank == null && banks?.unsolvedBank == null && banks?.bookTest == null ? Container() : SizedBox(
          width: double.infinity,
          child: Text(
            AppStrings.banks,
            style: getLargeStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0,),
        isWide(context) ? _buildBanksGrid(context, banks) : _buildBanksList(banks),
      ],
    );
  }

  ListView _buildExamsList(TeacherExam? exam) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        exam?.shortOne == null ? Container() : ExamItem(text: AppStrings.shortOne, link: exam?.shortOne ?? ''),
        exam?.shortTwo == null ? Container() : ExamItem(text: AppStrings.shortTwo, link: exam?.shortTwo ?? ''),
        exam?.unsolvedTest == null ? Container() : ExamItem(text: AppStrings.unsolvedTest, link: exam?.unsolvedTest ?? ''),
        exam?.solvedTest == null ? Container() : ExamItem(text: AppStrings.solvedTest, link: exam?.solvedTest ?? ''),
        exam?.finalReview == null ? Container() : ExamItem(text: AppStrings.finalReview, link: exam?.finalReview ?? ''),
      ],
    );
  }

  Widget _buildExamsGrid(BuildContext context, TeacherExam? exam) {
    List<String?> texts = [
      exam?.unsolvedTest,
      exam?.shortOne,
      exam?.shortTwo,
      exam?.finalReview,
    ];
    List<Widget> widgets = [
      exam?.shortOne == null ? Container() : ExamItem(text: AppStrings.shortOne, link: exam?.shortOne ?? ''),
      exam?.shortTwo == null ? Container() : ExamItem(text: AppStrings.shortTwo, link: exam?.shortTwo ?? ''),
      exam?.unsolvedTest == null ? Container() : ExamItem(text: AppStrings.unsolvedTest, link: exam?.unsolvedTest ?? ''),
      exam?.solvedTest == null ? Container() : ExamItem(text: AppStrings.solvedTest, link: exam?.solvedTest ?? ''),
      exam?.finalReview == null ? Container() : ExamItem(text: AppStrings.finalReview, link: exam?.finalReview ?? ''),
    ];
    List<Widget> appliedWidgets = [];
    int index = 0;
    for (var element in widgets) {
      if (texts[index++] != null) {
        appliedWidgets.add(element);
      }
    }
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 300).toInt(),
      childAspectRatio: 5.0,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(appliedWidgets.length, (index) {
        return appliedWidgets[index];
      }),
    );
  }

  ListView _buildBanksList(TeacherBank? bank) {
    return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              bank?.unsolvedBank == null ? Container() : ExamItem(text: AppStrings.unsolvedBank, link: bank?.unsolvedBank ?? ''),
              bank?.solvedBank == null ? Container() : ExamItem(text: AppStrings.solvedBank, link: bank?.solvedBank ?? ''),
              bank?.bookTest == null ? Container() : ExamItem(text: AppStrings.bookTest, link: bank?.bookTest ?? ''),
            ],
          );
  }

  Widget _buildBanksGrid(BuildContext context, TeacherBank? bank) {
    List<String?> texts = [
      bank?.unsolvedBank,
      bank?.solvedBank,
      bank?.bookTest,
    ];
    List<Widget> widgets = [
      bank?.unsolvedBank == null ? Container() : ExamItem(text: AppStrings.unsolvedBank, link: bank?.unsolvedBank ?? ''),
      bank?.solvedBank == null ? Container() : ExamItem(text: AppStrings.solvedBank, link: bank?.solvedBank ?? ''),
      bank?.bookTest == null ? Container() : ExamItem(text: AppStrings.bookTest, link: bank?.bookTest ?? ''),
    ];
    List<Widget> appliedWidgets = [];
    int index = 0;
    for (var element in widgets) {
      if (texts[index++] != null) {
        appliedWidgets.add(element);
      }
    }
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 300).toInt(),
      childAspectRatio: 5.0,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(appliedWidgets.length, (index) {
        return appliedWidgets[index];
      }),
    );
  }
}
