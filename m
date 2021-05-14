Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AF380C7B
	for <lists+linux-block@lfdr.de>; Fri, 14 May 2021 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhENPCQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 May 2021 11:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhENPCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:02:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E133C061756
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:01:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x8so8041113wrq.9
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kwmD0S5hoUSnS0BuZMSEzmXU4A8P17g/OZqHsDK0ccM=;
        b=biygoH8lL5B4KQXcngMVvghOfkVAEwqy7QLbR5F8DmHO+Gweqb7lNSCeaGa+ZD8YXv
         bo2skru+xxdQj2z+7yDQYSO+v4O0NnHIhBz+6tNenM5InEuq1vEqqs22V+hKZ72CO9OS
         +lHWlFySr5lG/HRO4+iDFupwspvQe00wckje/1t+DuvjIa/ktnNElW0tE0BWq+tK2ZXu
         zaM653i42EXEvK1vSfNVsCznOmGxL93Va3vCJa1fwbLQsqJlIQBWaQSmarCRzPAKI/o0
         jIS94e90pxUEip72mAf/XeDeuCB12cP/BaH8kthSQcgb/eIjXEEuDdn2J6LoszQ65aAZ
         Orbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=kwmD0S5hoUSnS0BuZMSEzmXU4A8P17g/OZqHsDK0ccM=;
        b=rTLH04oQn3ehOGBHNyH33EvEdgZcAnZgr1/Hl7sRs3GFV02LmMOgTRykIi/GIuH8HR
         hZ0ROqmLn9XJcp2nAbrUZsJHQdNzm3ATkwmOGym2+Bg5T65Gf9HGhqaZCLy/fUlL8iB0
         G526RqJS2SJOERp2E5AdASymwniG1C/KE4B4RjWhahUFHHihpZs+k7YiNhx4Yya2WnWR
         Ql31IdxWxvYzE30IefDxUqxRmjVOt2bnXMYMu8Rgh1rTUWmslmuZebjTqrggfPp9P5tN
         D46tFbpB57040UUQjeyz6tEbTG6sC68sYN9bHx/PbT7zv7paoN2zfXlAOz9JquA4rn6C
         ogRw==
X-Gm-Message-State: AOAM532dq1HIk30x5h8nDA8nyN25FKdHFS0+ALTIo1kMTXc1KUV16CeG
        J/McEKg/pTF6bD85oGehdeOD4pff5IOiW/ddJlo=
X-Google-Smtp-Source: ABdhPJz523QE1BZTfHeGeKeMuZ5OnGBvYOUH2aMls/tlHxiDmidhksodaHAogsfSt5k8jAJ+cItmkNeFd0Ii1+VtlbU=
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr58808036wrg.12.1621004460795;
 Fri, 14 May 2021 08:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:47af:0:0:0:0:0 with HTTP; Fri, 14 May 2021 08:01:00
 -0700 (PDT)
Reply-To: camillejackson021@gmail.com
In-Reply-To: <CAPHH3didOi82ZYJmjMzunYJn4933V956uV5zja0fiS3GenLSZQ@mail.gmail.com>
References: <CAPHH3didOi82ZYJmjMzunYJn4933V956uV5zja0fiS3GenLSZQ@mail.gmail.com>
From:   camille jackson <azougokaka@gmail.com>
Date:   Fri, 14 May 2021 15:01:00 +0000
Message-ID: <CAPHH3diPgYc3yGEz+vAVBwddn+E=x0X1gi02fYGRTon_0Duh_w@mail.gmail.com>
Subject: =?UTF-8?Q?J=C3=B3_nap?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

w5xkdsO2emxldCBuZWtlZCBiYXLDoXRvbSByZW3DqWxlbSBqw7NsIHZhZ3ksIGvDqXJsZWsgdsOh
bGFzem9saiBuZWtlbSBrw7ZzesO2bsO2bSwNCg==
