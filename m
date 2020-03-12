Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE318383A
	for <lists+linux-block@lfdr.de>; Thu, 12 Mar 2020 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCLSHR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Mar 2020 14:07:17 -0400
Received: from sonic311-14.consmr.mail.bf2.yahoo.com ([74.6.131.124]:34026
        "EHLO sonic311-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCLSHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 14:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584036435; bh=ntCsvVlsVYNXsouoo59ZH21v1wHZ5nZJzCG4NsnkusM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=D7FXcQjq5yGcy+9UIzGvT1auReeucJL/vbt5gI9v1BvxEUiXsH7PXBOKlF2c7onZaQ5lext8c/n4/H0eJE6l0B4524Q/wgMaPPa93cjRGxF3dUjPzeHUHvJp8yze8c+0chOflgmlPog66Q16OAymIRNO2RXG7ALiVaXricMM4PSwy4UbOWip8ZuP305aOzP/V1NlG8D1cIlOIx4SUp4qTiuE6a3e/dW6+5zHwpZZ3DroaN4wRvvotxDvejnN5OoZOEPCK3b15saARpKvYcf6YsC12WqOl3ml6VIE9lQK12fIu8yQnTDkd1as/B8HiVs0s5U701WJUBCz9XrFcHG+6g==
X-YMail-OSG: w8elTssVM1kLekshqqqpG5dwuLt4rZsZL2SOh1LrJwn5wlfYbp4Oo6MgbqkCpHK
 .uhAx7852VfKzGg4I6ikFIPUUBk5PEzxIY4c3lcoAQoqzUpGLjINEB35DIrvDvdgIK4EmWS6XUr4
 yx9tAnzjz9DeC90jwHCw7T904y1bc.NRvrDrAsl5ebjyVwAdbV5SQHYve4OTKYbxb59Z3TXTShTX
 MDZizxeBoLca.BKF4xZdH_Kejh__hhIAWf9iWfhYccAxyExubF6ANJt6oWoTVDnBrimLvpLHdZEp
 RmKhIsSAk8AOnhUMmIkhP7Zd.VI8nw3Ut58Beo1GStV_xdfDviaK4tRt3stftTp3FkF3CZrYbZF.
 r1SFu86mIGN_.9VipNxVUyrE_zCj4IFw9FKYgBOkRXJDFXtX9VhG4NqUpIVlYq5eJj46h_KnAP0w
 _qfkNKqpPQdcSfsB44acrLOjPKRto6mlqTqbk5UL4mScdHzKK0pyGJ6fpRXijbaZDSY3ixAbvWqb
 5FaroBfU8BN_3ORfSrWASolNAy1aTf_mai07nQuGKopYiv.M_x2iots6GKLHfiXI19Ny6NKcyI0u
 DpMrRMdflra3PIozB8lTnLEHUIs7ztYn9PCUOxyfXaf6zpCMQQF5zwbFDSOQg87817yBbR07s5B0
 L8RFXiHgbLFbOe_wX7MmhSDk5M99JSA7j02cw46dbsTMdZPplAxBjyAuBuTYb4Ttnu_tsrVxCaao
 tGsJix6_.Pranuw36rMEpzcih67sQTm58EA5xVAHpYpk6Mf0CAyXQA.yjElilQ5cGHWUcVV8Xopp
 1SW7hPCbT1CdPNm1BPRkKtvgHCyw3.ZWmB5iFxsaut04N.SQHGDrGjgNkH6tXu5UHf9z6Yt8nkQZ
 MGOo9nQ.ZhohduOcIKd6pY0ou6DsDlz9gbfsR7xWJ4Uk_M6tFhvbk.Fc37CQqA_XzOLDUTNVuV3H
 QglOo0Ca9zTZCX0SddxvMDmw3DaOh47uNvcOmo7QQFeGnZPiA3wmpUOTbxpYMSQyxPvNnpLKLGQj
 Uj_VvsHAUTHpYzYTg6mtpIkPfCRp0RnOBXbTmxOLlfxGkfxQOiQMtHzpQqVMIRNisnsQezhUObh3
 exWiIUOVdVclhvZxqolh4UJakqUeIf4t9t0VCc5_cORI1RjA.7fUc1WCUNWkr.p1LMDcH0Fq.CfH
 61_A3llKbtQ5e3f7vhA5IguHm6Lon_x9VSjMkUEh2avxD6za.k8JIDEEvcQqqybbsBhsTHkPvv8t
 RppHQT8B8zOkRsGnXaKXToFZECo6IZ88SHBZfZZ01wMvPbiLdmYMe16dLUJh1Y9rm3tT_7g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Mar 2020 18:07:15 +0000
Date:   Thu, 12 Mar 2020 18:07:14 +0000 (UTC)
From:   "Hello My Dear Beloved Friend," <akanbiakinbobola1@gmail.com>
Reply-To: miss.aminatouzainab@gmail.com
Message-ID: <666436464.2618536.1584036434795@mail.yahoo.com>
Subject: WITH DUE RESPECT YOUR ATTENTION IS VERY VERY NEEDED URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <666436464.2618536.1584036434795.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org





ATTENTION: DEAR BENEFICIARY CONGRATULATIONS TO YOU,

I RECEIVE YOUR CONTENT OF YOUR EMAIL FROM FEDEX ATM CARD OFFICES YOUR FUNDS SUM OF $10.500,000, 000. MILLION DOLLARS, HAS DISCOVER HERE AFTER THE BOARD OF DIRECTORS MEETINGS, THE UNITED NATIONS GOVERNMENT HAVE DECIDED TO ISSUE YOU YOUR (ATM CARD) VALUED @ TEN MILLION FIVE HUNDRED THOUSAND DOLLARS ($) COMPENSATION FUND THROUGH THIS (ATM) CARD.

THIS IS TO BRING TO YOUR NOTICE THAT YOUR VALUED SUM OF 10.5 MILLION DOLLARS HAS BEING CREDITED IN YOUR NAME AS BENEFICIARY TO THIS (ATM CARD), AND HAS BEEN HANDLE TO THE FOREIGN REMITTANCE DEPARTMENT TO SEND IT TO YOU IN YOUR FAVOR IMMEDIATELY WITHOUT ANY DELAY,

YOU HAVE ACCESS TO MAKE DAILY WITHDRAWALS OF ($5,500) UNITED STATE DOLLARS DAILY.

WE RECEIVE YOUR INFORMATIONS AND YOUR HOME ADDRESS OF YOUR COUNTRY AND WE WILL SEND TO YOU YOUR (ATM CARD), WE HAVE ALSO RECEIVED A SIGNAL FROM THE SWISS WORLD BANK TO TRANSFER YOUR BELONGING (ATM) TO YOU WITHIN ONE WEEK, WITHOUT ANY DELAY AS WE RECORD.

WE HAVE JUST FINISHED OUR ANNUAL GENERAL MEETING WITH BANK OF AMERICA (BOA).

FOR MORE INFORMATION PLEASE GET BACK TO ME AS SOON AS POSSIBLE.

YOURS
SINCERELY.

DIRECTOR FEDEX SERVICE (USA).
MRS. AMINATOU. Z. MAKEL.
