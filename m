Return-Path: <linux-block+bounces-1916-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB7830118
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45604285721
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC05125A5;
	Wed, 17 Jan 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PoHxYlY2"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFF125A3
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479343; cv=none; b=kE+xLyl8LPZ2Xdm5P30x68vTArLDxCeWR1S9EBJK4anFaNvLRrYULNqurORFJ4fN7K7K3N0z9gzMtFrlru8JwWY5bK1a0BhXu2YgTiV4/k29F0wdped72cMRr3lQy6tdYLwyDZEYlv7A5eYZ9ogUoWg6zkyF+K71vhjp7cepllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479343; c=relaxed/simple;
	bh=tPlu4RiUYk3N2MZILRGykiFpmAObUEuqJxX1DLwPr9E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=P1V3VkmKmQLXQ3bpoi/4m7OkRM6QnaW8F5GYoPJl0VQYb5zETCU9HzbDB1qSI0HM0oueVESt5g7lqHKvSlecUmYBpsI2b9vr/SKO/JvcxO/eDYCdwyVdB+2BvoYpw5VRc2X/JtP5t83sSm0dwbIIpVkrO2xxIYDPZIRl7ZNp4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PoHxYlY2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso12164463e87.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 00:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705479340; x=1706084140; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuxkbyAxuoH1akbvnEbu0efYi8wWnWpcQwcT8zxbzJM=;
        b=PoHxYlY27wKXm82xMtPIlb4gVC1rkkhKkPi4bs818564OVJSOgCy+fJ7tK4c1DGFOY
         0rnkcmsiDWaZCv8xbDwEdt7AxC/pcWHZh+zPcKV/bwmW6yBLIGkp2uq9bHoH98xIWEln
         MIx2hYIfciYjPpt0MCz22PYDgJ3+p1Y6+zliO9vsdXLGlA24EdZmhIMjCnF0i1nAL2JB
         ayK+XG8jhMf7iogAjJhhaLvwfEtaSwsEoukatuADtYOZNhdUaj9HH8QDyhOiOdb3YJlH
         4XhaHx31EaDST5RMPcjqlI4oKUd94+KcAmJ1fbMDnT/7TLNmgaqSNroRvLw7gH9xEB5A
         z4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479340; x=1706084140;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuxkbyAxuoH1akbvnEbu0efYi8wWnWpcQwcT8zxbzJM=;
        b=Oca1tx98preuAytXcWFdr4IzqWuG0eYdFow3t/DaDrEJq7sW5Th2fwA2+T3miy1R3F
         8uuFnQXkYQLlJTXTdoDwpiOZQCl+KN4D2iQ20NddXU+sQPBgKACaw93ybhAgQzwW36HO
         hwUp5lLnIybD3ScenRORvHqhxfqeGzS3eB37UAj3U/r2Z9JbGS/PW0XWIz4vPgaQEoOG
         HBduiUeEyFH5bcvFUW5zLdccYNbxoiYumdpiFvjTU2kpQdWZ+GYJiSeCHzWVHf/htuTu
         GqGkKoarkXYHmNrjU/GvtjkIstfszDVVYrAU7nNqSigsBwBae1pdPHB2lYxWR4z2uhfU
         xaHQ==
X-Gm-Message-State: AOJu0YyE60zB1vX/X6TLMhEceF3LJmOxSl9XnlXokgg7MXbcSdW4EtMa
	Hi7Dt8hI5JaPhRLUWt2rJ/L5iBHIMhN5qg==
X-Google-Smtp-Source: AGHT+IGPq9/Eq1UhC3pZj/TdkTfM+eftF0NMAfvDo4C1Okh8MAKtvC03cBl/8FarHZi42Or4ri4hjA==
X-Received: by 2002:a05:6512:ad5:b0:50e:7476:e027 with SMTP id n21-20020a0565120ad500b0050e7476e027mr2249734lfu.275.1705479340169;
        Wed, 17 Jan 2024 00:15:40 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:edb0:1c42:2f2b:211a])
        by smtp.gmail.com with ESMTPSA id t24-20020ac243b8000000b0050f09733c1esm168634lfl.267.2024.01.17.00.15.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 00:15:39 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
Date: Wed, 17 Jan 2024 11:15:34 +0300
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Message-Id: <FCE5827D-756D-44FA-9553-F74FA9A977BF@dubeyko.com>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 16, 2024, at 9:20 PM, Bart Van Assche <bvanassche@acm.org> wrote:
> 
> The advantages of zoned storage are well known [1]:
> * Higher sequential read and random read performance.
> * Lower write amplification.
> * Lower tail latency.
> * Higher usable capacity because of less overprovisioning.
> 
> 

<skipped>

> 
> In other words, this proposal is about supporting both the Write and
> Zone Append commands as first class operations and to let filesystem
> implementers decide which command(s) to use.
> 

I am interested to attend the discussion.

Thanks,
Slava.


