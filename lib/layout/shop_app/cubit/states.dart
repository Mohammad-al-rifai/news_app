import 'package:pl/models/shop_app/home_model.dart';
import 'package:pl/models/shop_app/login_model.dart';
import 'package:pl/models/shop_app/product_details_model.dart';
import 'package:pl/models/shop_app/update_product_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}


class ShopLoadingUserDataState extends ShopStates {}


class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}


class ShopErrorUserDataState extends ShopStates {}

//  ====================================================

class ShopLoadingUpdateProductState extends ShopStates {}


class ShopSuccessUpdateProductState extends ShopStates {
  final UpdateProModel updateProModel;

  ShopSuccessUpdateProductState(this.updateProModel);
}


class ShopErrorUpdateProductState extends ShopStates {}


// ========== Image Upload States

class ShopLoadingImageUploadState extends ShopStates {}


class ShopSuccessImageUploadState extends ShopStates {}


class ShopErrorImageUploadState extends ShopStates {}

// ========== Create Product States

class ShopLoadingCreateProductState extends ShopStates {}


class ShopSuccessCreateProductState extends ShopStates {}


class ShopErrorCreateProductState extends ShopStates {}


// ========== Product's Details States


class ShopLoadingProDetailsDataState extends ShopStates {}

class ShopSuccessProDetailsDataState extends ShopStates {
  final DetailsModel detailsModel;

  ShopSuccessProDetailsDataState(this.detailsModel);
}

class ShopErrorProDetailsDataState extends ShopStates {}

// ========== Delete Product States


class ShopLoadingDeleteProductState extends ShopStates {}

class ShopSuccessDeleteProductState extends ShopStates {}

class ShopErrorDeleteProductState extends ShopStates {}


// ========== Comment Product States

class CommentLoadingState extends ShopStates {}

class CommentSuccessState extends ShopStates {}

class CommentErrorState extends ShopStates {}


// ========== Comment Product States

class LikeLoadingState extends ShopStates {}

class LikeSuccessState extends ShopStates {}

class LikeErrorState extends ShopStates {}

// ========== Comment Product States


class ShopChangeLikeState extends ShopStates {}

// ========== Comment Product States

class ShopLoadingMyPostsState extends ShopStates {}

class ShopSuccessMyPostsState extends ShopStates {}

class ShopErrorMyPostsState extends ShopStates {}

