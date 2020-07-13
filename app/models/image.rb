class Image < ApplicationRecord
  belongs_to :user

  def self.cloud_search(current_user)
    Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute
  end

  def self.user_images(current_user)
      Image.all.select {|picture| current_user.id == picture.user_id}
  end

  def self.add(id)
    current_user = User.find_by_id(id)

    result = self.cloud_search(current_user)
    current_album = self.user_images(current_user)

    current_album_urls = []
    current_album.each {|image| current_album_urls << image.public_id}
    file = result["resources"]
    file.each do |ele|
      if (current_album_urls.include?(ele["public_id"]))
        else
          pic = Image.one_face(url)

          det = pic.face_details[0]
          land = pic.face_details[0]["landmarks"]
          qual = pic.face_details[0]["quality"]

    @new_image = Image.new(:name => file[i]["filename"], :url => file[i]["url"], :user_id => id, :public_id => file[i]["public_id"], :box_width => det.bounding_box.width.to_s, :box_height => det.bounding_box.height.to_s, :box_left => det.bounding_box.left.to_s, :box_top => det.bounding_box.top.to_s, :age_low => det.age_range.low, :age_high => det.age_range.high, :eyeglasses => det.eyeglasses.value, :eyeglass_con => det.eyeglasses.confidence.to_s, :gender => det.gender.value, :gender_con => det.gender.confidence.to_s, :beard => det.beard.value, :beard_con => det.beard.confidence.to_s, :mustache => det.mustache.value, :mustache_con => det.mustache.confidence.to_s, :eyeLeft => (land[0].x.to_s + '/' + land[0].y.to_s), :eyeRight => (land[1].x.to_s + '/' + land[1].y.to_s), :mouthLeft => (land[2].x.to_s + '/' + land[2].y.to_s), :mouthRight => (land[3].x.to_s + '/' + land[3].y.to_s), :nose => (land[4].x.to_s + '/' + land[4].y.to_s), :leftEyeBrowLeft => (land[5].x.to_s + '/' + land[5].y.to_s), :leftEyeBrowRight => (land[6].x.to_s + '/' + land[6].y.to_s), :leftEyeBrowUp => (land[7].x.to_s + '/' + land[7].y.to_s), :rightEyeBrowLeft => (land[8].x.to_s + '/' + land[8].y.to_s), :rightEyeBrowRight => (land[9].x.to_s + '/' + land[9].y.to_s), :rightEyeBrowUp => (land[10].x.to_s + '/' + land[10].y.to_s), :leftEyeLeft => (land[11].x.to_s + '/' + land[11].y.to_s), :leftEyeRight => (land[12].x.to_s + '/' + land[12].y.to_s), :leftEyeUp => (land[13].x.to_s + '/' + land[13].y.to_s), :leftEyeDown => (land[14].x.to_s + '/' + land[14].y.to_s), :rightEyeLeft => (land[15].x.to_s + '/' + land[15].y.to_s), :rightEyeRight => (land[16].x.to_s + '/' + land[16].y.to_s), :rightEyeUp => (land[17].x.to_s + '/' + land[17].y.to_s), :rightEyeDown => (land[18].x.to_s + '/' + land[18].y.to_s), :noseLeft => (land[19].x.to_s + '/' + land[19].y.to_s), :noseRight => (land[20].x.to_s + '/' + land[20].y.to_s), :mouthUp => (land[21].x.to_s + '/' + land[21].y.to_s), :mouthDown => (land[22].x.to_s + '/' + land[22].y.to_s), :leftPupil => (land[23].x.to_s + '/' + land[23].y.to_s), :rightPupil => (land[24].x.to_s + '/' + land[24].y.to_s), :upperJawlineLeft => (land[25].x.to_s + '/' + land[25].y.to_s), :midJawlineLeft => (land[26].x.to_s + '/' + land[26].y.to_s), :chinBottom => (land[27].x.to_s + '/' + land[27].y.to_s), :midJawlineRight => (land[28].x.to_s + '/' + land[28].y.to_s), :upperJawlineRight => (land[29].x.to_s + '/' + land[29].y.to_s), :brightness => qual.brightness, :sharpness => qual.sharpness, :compare_result => "", :label => "")

    @new_image.save
      end
    end
  end

  def open(url)
    Net::HTTP.get(URI.parse(url))
  end

  def self.process(source, target)
    access_key = Rails.application.credentials[:aws][:access_key_id]
    secret_key = Rails.application.credentials[:aws][:secret_access_key]
    client = Aws::Rekognition::Client.new credentials: Aws::Credentials.new(access_key, secret_key)

     file1 = open(source) {|f| f.read}
     file2 = open(target) {|f| f.read}

     resp = client.compare_faces({
       similarity_threshold: 90,
       source_image: {
         bytes: file1
       },
       target_image: {
         bytes: file2
       },
      })
  end

  def self.one_face(source)
    access_key = Rails.application.credentials[:aws][:access_key_id]
    secret_key = Rails.application.credentials[:aws][:secret_access_key]
    client = Aws::Rekognition::Client.new credentials: Aws::Credentials.new(access_key, secret_key)

    file1 = open(source) {|f| f.read}

    resp = client.detect_faces({
      image: {
        bytes: file1
      },
      attributes: ["ALL"]
    })
    resp
  end

  def self.pirate_rekon(source, target)
    diff = 0.03
    pos_counter = 0
    neg_counter = 0

      diff_bound_w = (source.box_width.to_f - target.box_width.to_f).abs()
      diff_bound_h = (source.box_height.to_f - target.box_height.to_f).abs()
      diff_bound_left = (source.box_left.to_f - target.box_left.to_f).abs()
      diff_bound_top = (source.box_top.to_f - target.box_top.to_f).abs()

          bound_diff = [diff_bound_w, diff_bound_h, diff_bound_left, diff_bound_top]

       age_low_bottom = source.age_low - 2
       age_low_top = source.age_low + 2

       age_high_bottom = source.age_high - 2
       age_high_top = source.age_high + 2

       if (age_low_bottom..age_low_top).include?(target.age_low) && (age_high_bottom..age_high_top).include?(target.age_high)
         pos_counter += 1
       end

       (pos_counter += 1) if source.eyeglasses == target.eyeglasses
       (neg_counter += 10) if source.eyeglasses != target.eyeglasses

       (pos_counter += 1) if (95..(99.9)).include?(source.eyeglass_con.to_f) && ((0.80)..(0.99)).include?(source.eyeglass_con.to_f)

       source.gender == target.gender ? (pos_counter += 1) : (neg_counter += 100) unless source.gender_con.to_f < 80 || target.gender_con.to_f < 80

       (pos_counter += 1) if source.beard == target.beard unless source.beard_con.to_f < 85 || target.beard_con.to_f < 85
       (neg_counter += 7) if source.beard != target.beard

       (pos_counter += 1) if source.mustache == target.mustache unless source.mustache_con.to_f < 90 || target.mustache_con.to_f < 90

          source_array = [source.eyeLeft,
            source.eyeRight,
            source.mouthLeft,
            source.mouthRight,
            source.nose,
            source.leftEyeBrowLeft,
            source.leftEyeBrowRight,
            source.leftEyeBrowUp,
            source.rightEyeBrowLeft,
            source.rightEyeBrowRight,
            source.rightEyeBrowUp,
            source.leftEyeLeft,
            source.leftEyeRight,
            source.leftEyeUp,
            source.leftEyeDown,
            source.rightEyeLeft,
            source.rightEyeRight,
            source.rightEyeUp,
            source.rightEyeDown,
            source.noseLeft,
            source.noseRight,
            source.mouthUp,
            source.mouthDown,
            source.leftPupil,
            source.rightPupil,
            source.upperJawlineLeft,
            source.midJawlineLeft,
            source.chinBottom,
            source.midJawlineRight,
            source.upperJawlineRight]

            source.brightness
            source.sharpness

            target_array = [target.eyeLeft,
              target.eyeRight,
              target.mouthLeft,
              target.mouthRight,
              target.nose,
              target.leftEyeBrowLeft,
              target.leftEyeBrowRight,
              target.leftEyeBrowUp,
              target.rightEyeBrowLeft,
              target.rightEyeBrowRight,
              target.rightEyeBrowUp,
              target.leftEyeLeft,
              target.leftEyeRight,
              target.leftEyeUp,
              target.leftEyeDown,
              target.rightEyeLeft,
              target.rightEyeRight,
              target.rightEyeUp,
              target.rightEyeDown,
              target.noseLeft,
              target.noseRight,
              target.mouthUp,
              target.mouthDown,
              target.leftPupil,
              target.rightPupil,
              target.upperJawlineLeft,
              target.midJawlineLeft,
              target.chinBottom,
              target.midJawlineRight,
              target.upperJawlineRight]

              bright = (source.brightness.to_f - target.brightness.to_f).abs()
              sharp = (source.sharpness.to_f - target.sharpness.to_f).abs()

              test = []
              (0...target_array.length).each do |i|
                pic1 = target_array[i].split("/")
                pic2 = source_array[i].split("/")
                val1 = ((pic1[0].to_f) - (pic2[0].to_f))
                val2 = ((pic1[1].to_f) - (pic2[1].to_f))
                pos_counter += 1 if val2.abs() < 0.043
                neg_counter += 4 if val2.abs() > 0.09
                pos_counter += 1 if val1.abs() < 0.1
                neg_counter += 4 if val1.abs() > 0.2
                test << [val1, val2]
              end

              analysis = {
                :bound_box => bound_diff,
                :bright_diff => bright,
                :sharp_diff => sharp,
              }

              if analysis[:sharp_diff] < 3
                pos_counter += 1
              elsif analysis[:sharp_diff] > 8
                neg_counter += 20
              end

              if analysis[:bright_diff] < 1
                pos_counter += 1
              elsif analysis[:bright_diff] > 2
                neg_counter += 5
              end

              if analysis[:bound_box][0] < 0.1
                pos_counter += 1
              end
              if analysis[:bound_box][0] > 0.2
                neg_counter += 5
              end
              if analysis[:bound_box][1] < 0.1
                pos_counter += 1
              end
              if analysis[:bound_box][1] > 0.2
                neg_counter += 5
              end
              if analysis[:bound_box][2] < 0.01
                pos_counter += 1
              end
              if analysis[:bound_box][2] > 0.02
                neg_counter += 5
              end
              if analysis[:bound_box][3] < 0.05
                pos_counter += 1
              end
              if analysis[:bound_box][3] > 0.1
                neg_counter += 5
              end

              result = [pos_counter, neg_counter]
              result

          end
        end
