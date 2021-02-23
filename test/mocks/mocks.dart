import 'package:boticario_news/domain/entities/message_entity.dart';
import 'package:boticario_news/domain/entities/post_entity.dart';
import 'package:boticario_news/domain/entities/user_entity.dart';
import 'package:boticario_news/ui/pages/feed/post_viewmodel.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

const apiResponseNewsBoticario = """
{
   "news":[
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg"
         },
         "message":{
            "content":"Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?",
            "created_at":"2020-02-02T16:10:33Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg"
         },
         "message":{
            "content":"Com a união das demais marcas do grupo, doamos 216 toneladas de produtos de higiene para comunidades em vulnerabilidade social de diversas partes do país.",
            "created_at":"2020-02-02T15:10:33Z"
         }
      }
   ]
}
""";

const apiResponsePosts = """
  [
  {
    "id": 3,
    "users_permissions_user": {
      "id": 2,
      "username": "juca",
      "email": "juca@mail.com",
      "provider": "local",
      "confirmed": true,
      "blocked": null,
      "role": 1,
      "created_at": "2021-01-23T14:39:07.779Z",
      "updated_at": "2021-01-23T14:39:07.787Z"
    },
    "published_at": "2021-01-23T14:40:12.678Z",
    "created_at": "2021-01-23T14:40:12.681Z",
    "updated_at": "2021-01-23T14:40:12.714Z",
    "message": {
      "id": 3,
      "content": "Vai que da"
    }
  },
  {
    "id": 4,
    "users_permissions_user": {
      "id": 2,
      "username": "juca",
      "email": "juca@mail.com",
      "provider": "local",
      "confirmed": true,
      "blocked": null,
      "role": 1,
      "created_at": "2021-01-23T14:39:07.779Z",
      "updated_at": "2021-01-23T14:39:07.787Z"
    },
    "published_at": "2021-01-23T23:41:46.958Z",
    "created_at": "2021-01-23T23:41:46.969Z",
    "updated_at": "2021-01-23T23:41:47.010Z",
    "message": {
      "id": 4,
      "content": "Vai que da isdfj de novo vai mai usdf"
    }
  }
]
""";

List<PostEntity> newsList = [
  PostEntity(
    message: MessageEntity(
      content: faker.lorem.sentence(),
      createdAt: DateTime(2020, 02, 20),
    ),
    user: UserEntity(
      name: faker.person.name(),
      profilePicture: faker.internet.httpsUrl(),
    ),
  ),
  PostEntity(
    message: MessageEntity(
      content: faker.lorem.sentence(),
      createdAt: DateTime(2018, 08, 14),
    ),
    user: UserEntity(
      name: faker.person.name(),
      profilePicture: faker.internet.httpsUrl(),
    ),
  ),
];

final postsViewModel = newsList
    .map(
      (post) => NewsViewModel(
        id: post?.id,
        message: post?.message?.content,
        date: DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR')
            .format(post?.message?.createdAt),
        user: post?.user?.name,
        userId: post?.user?.id,
      ),
    )
    .toList();

const factoryApiResponse = """
{
  "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
  "user": {
    "id": 2,
    "username": "juca",
    "email": "juca@mail.com",
    "provider": "local",
    "confirmed": true,
    "blocked": null,
    "role": {
      "id": 1,
      "name": "Authenticated",
      "description": "Default role given to authenticated user.",
      "type": "authenticated"
    },
    "created_at": "2021-01-23T14:39:07.779Z",
    "updated_at": "2021-01-23T14:39:07.787Z"
  }
}
""";

const factoryNewPostApiResponse = """
{
  "id": 4,
  "users_permissions_user": {
    "id": 1,
    "username": "user",
    "email": "user@mail.com",
    "provider": "local",
    "confirmed": true,
    "blocked": null,
    "role": 1,
    "created_at": "2021-01-23T14:39:07.779Z",
    "updated_at": "2021-01-23T14:39:07.787Z"
  },
  "published_at": "2021-01-23T23:41:46.958Z",
  "created_at": "2021-01-23T23:41:46.969Z",
  "updated_at": "2021-01-23T23:41:47.010Z",
  "message": {
    "id": 4,
    "content": "message"
  }
}
""";
