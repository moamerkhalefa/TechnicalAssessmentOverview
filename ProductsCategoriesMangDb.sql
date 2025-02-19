USE [ProductsCategoriesMangDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 1/6/2025 1:24:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 1/6/2025 1:24:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[Id] [uniqueidentifier] NOT NULL,
	[Timestamp] [datetime2](7) NOT NULL,
	[Action] [nvarchar](max) NOT NULL,
	[EntityName] [nvarchar](max) NOT NULL,
	[EntityId] [uniqueidentifier] NOT NULL,
	[OldValues] [nvarchar](max) NULL,
	[NewValues] [nvarchar](max) NULL,
	[UserId] [nvarchar](max) NULL,
	[IPAddress] [nvarchar](max) NULL,
 CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/6/2025 1:24:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[ParentCategoryId] [uniqueidentifier] NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/6/2025 1:24:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[Status] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241230190748_InitDbMigration', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241230215310_addProductsTblMig', N'8.0.11')
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'57dbd397-4c1a-4c8c-430d-08dd2dae2233', CAST(N'2025-01-05T19:26:47.7728867' AS DateTime2), N'Create', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', NULL, N'Name: Category 4, Description: Description 1,Parent: 208e3232-5cb0-4015-8e88-47b33e14fd7a, Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'e5092e15-6b50-46d4-430e-08dd2dae2233', CAST(N'2025-01-05T19:27:31.3233919' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 1,Parent: 208e3232-5cb0-4015-8e88-47b33e14fd7a, Status: Active', N'Name: Category 4, Description: Description 1,Parent: , Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'57df6dd9-6dbf-4f4c-430f-08dd2dae2233', CAST(N'2025-01-05T19:28:34.0074145' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 1,Parent: , Status: Active', N'Name: Category 4, Description: Description 1,Parent: , Status: Inactive', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'4d45d74d-7244-4bc5-4731-08dd2dc7173c', CAST(N'2025-01-05T22:25:26.7920809' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 1,Parent: , Status: Inactive', N'Name: Category 4, Description: Description 4,Parent: , Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'17edefe9-4beb-4cd0-4732-08dd2dc7173c', CAST(N'2025-01-05T22:31:35.4903055' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 4,Parent: , Status: Active', N'Name: Category 4, Description: Description 4,Parent: 7707ebb4-9f61-45e0-972c-31a93bc82923, Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'47f10631-eb42-4c57-4733-08dd2dc7173c', CAST(N'2025-01-05T22:32:09.4963422' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 4,Parent: 7707ebb4-9f61-45e0-972c-31a93bc82923, Status: Active', N'Name: Category 4, Description: Description 4,Parent: 7707ebb4-9f61-45e0-972c-31a93bc82923, Status: Inactive', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'802885bf-1117-4c7c-4734-08dd2dc7173c', CAST(N'2025-01-05T22:49:33.3468528' AS DateTime2), N'Update', N'Category', N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Name: Category 4, Description: Description 4,Parent: 7707ebb4-9f61-45e0-972c-31a93bc82923, Status: Inactive', N'Name: Category 4, Description: Description 4,Parent: 208e3232-5cb0-4015-8e88-47b33e14fd7a, Status: Inactive', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'dffde280-f5a0-4051-4735-08dd2dc7173c', CAST(N'2025-01-05T22:49:40.3951911' AS DateTime2), N'Update', N'Category', N'7707ebb4-9f61-45e0-972c-31a93bc82923', N'Name: test, Description: ggffggf,Parent: , Status: Active', N'Name: test, Description: ggffggf,Parent: 31fd6415-9668-43fb-ae08-7c259f427370, Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'1e1fa8b6-e6ee-4750-4736-08dd2dc7173c', CAST(N'2025-01-06T00:24:35.3541732' AS DateTime2), N'Create', N'Category', N'1389ab86-4734-439e-bd72-3919a78a3a06', NULL, N'Name: Category 5, Description: Description 5,Parent: 398fda42-1586-4c0c-8452-004cf1b6e9df, Status: Active', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'374bf034-4b14-41e6-82fc-08dd2de70ca4', CAST(N'2025-01-06T02:14:12.9167700' AS DateTime2), N'Create', N'Product', N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', NULL, N'Name: Product 1, Description: Description 1, Price: 122, CategoryId: 7707ebb4-9f61-45e0-972c-31a93bc82923, Quantity: 11, Status: Active, Image: ../../../public/package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'9a95d770-1254-4526-34b3-08dd2de9236a', CAST(N'2025-01-06T02:29:10.1133004' AS DateTime2), N'Update', N'Product', N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', N'Name: Product 1, Description: Description 1, Price: 122.00, Quantity: 11, Status: Active, Image: ../../../public/package2.png', N'Name: Product 1, Description: Description 1, Price: 122, Quantity: 11, Status: Active, Image: assets/images/package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'0e30faea-f80e-4369-34b4-08dd2de9236a', CAST(N'2025-01-06T02:39:26.5970239' AS DateTime2), N'Update', N'Product', N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', N'Name: Product 1, Description: Description 1, Price: 122.00, Quantity: 11, Status: Active, Image: assets/images/package2.png', N'Name: Product 1, Description: Description 1, Price: 122, Quantity: 11, Status: Active, Image: /package.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'ab085ad0-3ff6-4065-34b5-08dd2de9236a', CAST(N'2025-01-06T02:39:44.3372901' AS DateTime2), N'Update', N'Product', N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', N'Name: Product 1, Description: Description 1, Price: 122.00, Quantity: 11, Status: Active, Image: /package.png', N'Name: Product 1, Description: Description 1, Price: 122, Quantity: 11, Status: Active, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'cfb30e25-898c-4a2d-34b6-08dd2de9236a', CAST(N'2025-01-06T02:44:57.4715136' AS DateTime2), N'Create', N'Product', N'e54a4a1d-2a74-4ae4-b3c2-4746bc533eae', NULL, N'Name: fgkjgfjk, Description: gklflgkl, Price: 5, CategoryId: 1389ab86-4734-439e-bd72-3919a78a3a06, Quantity: 0, Status: Discontinued, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'694f88e8-6378-4c67-34b7-08dd2de9236a', CAST(N'2025-01-06T02:47:02.9346184' AS DateTime2), N'Update', N'Product', N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', N'Name: Product 1, Description: Description 1, Price: 122.00, Quantity: 11, Status: Active, Image: /package2.png', N'Name: Product 1, Description: Description 1, Price: 122, Quantity: 11, Status: Inactive, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'56164569-4125-4cf4-34b8-08dd2de9236a', CAST(N'2025-01-06T02:53:23.0807782' AS DateTime2), N'Create', N'Product', N'0f96c419-dd21-4399-8a68-5c55b526f399', NULL, N'Name: Product 2, Description: Description 2, Price: 46, CategoryId: 31fd6415-9668-43fb-ae08-7c259f427370, Quantity: 66, Status: Active, Image: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRuKYaQLClKksDodsBje138bY-lr_SClKDFQ&s', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'659e9f55-1918-4699-34b9-08dd2de9236a', CAST(N'2025-01-06T02:53:50.4326792' AS DateTime2), N'Delete', N'Product', N'e54a4a1d-2a74-4ae4-b3c2-4746bc533eae', N'Name: fgkjgfjk, Description: gklflgkl, Price: 5.00, Quantity: 0, Status: Discontinued, Image: /package2.png', NULL, NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'd1ae79a4-f750-4c12-c53b-08dd2e214e3c', CAST(N'2025-01-06T09:11:13.7768158' AS DateTime2), N'Create', N'Product', N'2bc0394e-e922-49cf-bcb6-34c9925240fe', NULL, N'Name: Product 3, Description: ffggffg, Price: 4, CategoryId: 208e3232-5cb0-4015-8e88-47b33e14fd7a, Quantity: 5, Status: Inactive, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'8c303326-330b-4651-8ba8-08dd2e256c04', CAST(N'2025-01-06T09:40:41.7233456' AS DateTime2), N'Update', N'Product', N'0f96c419-dd21-4399-8a68-5c55b526f399', N'Name: Product 2, Description: Description 2, Price: 46.00, Quantity: 66, Status: Active, Image: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRuKYaQLClKksDodsBje138bY-lr_SClKDFQ&s', N'Name: Product 2, Description: Description 2, Price: 46, Quantity: 66, Status: Inactive, Image: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRuKYaQLClKksDodsBje138bY-lr_SClKDFQ&s', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'55a82b94-4f3a-427e-64ee-08dd2e3f61ed', CAST(N'2025-01-06T12:46:31.7152356' AS DateTime2), N'Create', N'Product', N'fd45dbc2-4289-4b90-8ee0-90cb4b2b6e1f', NULL, N'Name: Product  4, Description: ffggffg, Price: 5, CategoryId: 1389ab86-4734-439e-bd72-3919a78a3a06, Quantity: 12, Status: Discontinued, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'5ccc71d2-13e8-47c5-64ef-08dd2e3f61ed', CAST(N'2025-01-06T12:47:08.2496773' AS DateTime2), N'Create', N'Product', N'a014a81a-0684-4277-8cf3-7ae870f320cd', NULL, N'Name: Product 5, Description: ffgggf, Price: 55, CategoryId: 1389ab86-4734-439e-bd72-3919a78a3a06, Quantity: 25, Status: Active, Image: /package2.png', NULL, NULL)
INSERT [dbo].[AuditLogs] ([Id], [Timestamp], [Action], [EntityName], [EntityId], [OldValues], [NewValues], [UserId], [IPAddress]) VALUES (N'c7835b1f-1da9-4b5e-64f0-08dd2e3f61ed', CAST(N'2025-01-06T12:47:40.2825300' AS DateTime2), N'Create', N'Product', N'a3a62892-c84d-4e5c-91a1-e8cfe9f77eac', NULL, N'Name: Product 6, Description: gffgddd, Price: 80, CategoryId: f1ec61d7-d367-4c76-85e9-b629f0a32e7b, Quantity: 43, Status: Active, Image: /package2.png', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'398fda42-1586-4c0c-8452-004cf1b6e9df', N'Category 4', N'Description 4', N'208e3232-5cb0-4015-8e88-47b33e14fd7a', 2, CAST(N'2025-01-05T17:26:46.8969366' AS DateTime2), CAST(N'2025-01-05T20:49:33.3341757' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'7707ebb4-9f61-45e0-972c-31a93bc82923', N'test', N'ggffggf', N'31fd6415-9668-43fb-ae08-7c259f427370', 1, CAST(N'2025-01-05T16:28:07.3655588' AS DateTime2), CAST(N'2025-01-05T20:49:40.3842158' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'1389ab86-4734-439e-bd72-3919a78a3a06', N'Category 5', N'Description 5', N'398fda42-1586-4c0c-8452-004cf1b6e9df', 1, CAST(N'2025-01-05T22:24:35.3363000' AS DateTime2), CAST(N'2025-01-05T22:24:35.3363792' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'208e3232-5cb0-4015-8e88-47b33e14fd7a', N'Category 2', N'Category 2 Description', N'31fd6415-9668-43fb-ae08-7c259f427370', 1, CAST(N'2025-01-05T13:43:03.9349443' AS DateTime2), CAST(N'2025-01-05T16:13:25.4198335' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'31fd6415-9668-43fb-ae08-7c259f427370', N'Category 1', N'Description Description Description', N'7707ebb4-9f61-45e0-972c-31a93bc82923', 2, CAST(N'2025-01-04T22:06:11.2427059' AS DateTime2), CAST(N'2025-01-05T16:28:16.5710590' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [Description], [ParentCategoryId], [Status], [CreatedDate], [UpdatedDate]) VALUES (N'f1ec61d7-d367-4c76-85e9-b629f0a32e7b', N'Category 3', N'Description sgsg g fggggf', N'208e3232-5cb0-4015-8e88-47b33e14fd7a', 1, CAST(N'2025-01-05T16:14:40.1012823' AS DateTime2), CAST(N'2025-01-05T16:20:56.9680139' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'2bc0394e-e922-49cf-bcb6-34c9925240fe', N'Product 3', N'ffggffg', CAST(4.00 AS Decimal(18, 2)), N'208e3232-5cb0-4015-8e88-47b33e14fd7a', 2, 5, N'/package2.png', CAST(N'2025-01-06T07:11:13.6053031' AS DateTime2), CAST(N'2025-01-06T07:11:13.6053252' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'0f96c419-dd21-4399-8a68-5c55b526f399', N'Product 2', N'Description 2', CAST(46.00 AS Decimal(18, 2)), N'31fd6415-9668-43fb-ae08-7c259f427370', 2, 66, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRuKYaQLClKksDodsBje138bY-lr_SClKDFQ&s', CAST(N'2025-01-06T00:53:23.0696486' AS DateTime2), CAST(N'2025-01-06T07:40:41.6265866' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'a014a81a-0684-4277-8cf3-7ae870f320cd', N'Product 5', N'ffgggf', CAST(55.00 AS Decimal(18, 2)), N'1389ab86-4734-439e-bd72-3919a78a3a06', 1, 25, N'/package2.png', CAST(N'2025-01-06T10:47:08.2400623' AS DateTime2), CAST(N'2025-01-06T10:47:08.2400624' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'fd45dbc2-4289-4b90-8ee0-90cb4b2b6e1f', N'Product  4', N'ffggffg', CAST(5.00 AS Decimal(18, 2)), N'1389ab86-4734-439e-bd72-3919a78a3a06', 3, 12, N'/package2.png', CAST(N'2025-01-06T10:46:31.6072644' AS DateTime2), CAST(N'2025-01-06T10:46:31.6072878' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'26e206b1-8db2-4deb-b4d6-e4eb0582770c', N'Product 1', N'Description 1', CAST(122.00 AS Decimal(18, 2)), N'7707ebb4-9f61-45e0-972c-31a93bc82923', 2, 11, N'/package2.png', CAST(N'2025-01-06T00:14:12.7471863' AS DateTime2), CAST(N'2025-01-06T00:47:02.9233293' AS DateTime2))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CategoryId], [Status], [StockQuantity], [ImageUrl], [CreatedDate], [UpdatedDate]) VALUES (N'a3a62892-c84d-4e5c-91a1-e8cfe9f77eac', N'Product 6', N'gffgddd', CAST(80.00 AS Decimal(18, 2)), N'f1ec61d7-d367-4c76-85e9-b629f0a32e7b', 1, 43, N'/package2.png', CAST(N'2025-01-06T10:47:40.2704206' AS DateTime2), CAST(N'2025-01-06T10:47:40.2704207' AS DateTime2))
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories_ParentCategoryId] FOREIGN KEY([ParentCategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories_ParentCategoryId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
